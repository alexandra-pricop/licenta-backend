class Api::V1::PatronController < Api::V1::ApiController
  before_action :authorize_user
  protect_from_forgery with: :null_session,
    if: Proc.new { |c| c.request.format =~ %r{application/json} }

  api :POST, "/patron/create_company", "Rol patron: Patronul cere sa inregistreze o companie"
  param :company, Hash, :required => true do
    param :name, String, "Name of a :resource", required: true 
    param :cui, String, "CUI", required: true 
  end
  returns code: 200, desc: "a successful response" do
    property :company, Hash do
      property :id, Integer, "An integer value"
      property :name, String, "A string value"
      property :cui, String, "A string value"
      property :status, ["cerere"], "One of possible string values"
    end
  end
  def create_company
    @company = Company.new(company_params)
    # Patronul trebuie sa aiba toate drepturile pe rapoarte
    @company.company_users.build(user: current_user, status: "aprobat", meta_data: {"categories" => Document::REPORTS})
    if @company.save
      render json: { company: @company.serialize }
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  api :GET, "/patron/list_company_requests", "Rol patron: Listare cereri inregistrare companii in asteptare"
  def list_company_requests
    # doar in asteptare
    render json: current_user.companies.cerere.map(&:serialize)
    # in asteptare si refuzate
    # render json: (current_user.companies.cerere.or(current_user.companies.refuzat)).map(&:serialize)
  end


  api :GET, "/patron/list_join_requests", "Rol patron: Listare cereri aplicare angajati in asteptare pe 1 firma"
  def list_join_requests
    @company = current_user.companies.find(params[:company_id])
    render json: @company.company_users.cerere.map(&:serialize)
  end

  api :POST, "/patron/accept_join", "Rol patron: Accepta o aplicatie angajat in companie"
  param :company_id, Integer, "Id-ul companiei", required: true
  param :company_user_id, Integer, "ID-ul cererii din list_join_requests", required: true
  def accept_join
    @company = current_user.companies.find(params[:company_id])
    @company_user = @company.company_users.find_by(id: params[:company_user_id], status: "cerere")
    if @company_user.update(status: "aprobat")
      render json: @company_user.serialize
    else
      render json: @company_user.errors, status: :unprocessable_entity
    end
  end

  api :POST, "/patron/reject_join", "Rol patron: Refuza o aplicatie angajat in companie"
  param :company_id, Integer, "Id-ul companiei", required: true
  param :company_user_id, Integer, "ID-ul cererii din list_join_requests", required: true  
  def reject_join
    @company = current_user.companies.find(params[:company_id])
    @company_user = @company.company_users.find_by(id: params[:company_user_id], status: "cerere")
    if @company_user.destroy
      head 204
    else
      render json: @company_user.errors, status: :unprocessable_entity
    end
  end

  api :GET, "/patron/list_users", "Rol patron: Listeaza angajatii care au acces in 1 companie"
  def list_users
    @company = current_user.companies.find(params[:company_id])
    render json: @company.users.angajat.joins(:company_users).where("company_users.status = 1").distinct.map(&:serialize)
  end

  api :POST, "/patron/remove_user", "Rol patron: Sterge accesul unui angajat din 1 companie"
  param :company_id, Integer, "Id-ul companiei", required: true
  param :user_id, Integer, "ID-ul angajatului obtinut din list_users", required: true 
  def remove_user
    @company = current_user.companies.find(params[:company_id])
    @company_user = @company.company_users.find_by(user_id: params[:user_id])
    if @company_user.nil?
      render json: {error: "User not found for this company"}, status: :not_found
      return
    end
    if @company_user.destroy
        head 204
    else
        render json: {errors: {remove_user: 'error'}}, status: :unprocessable_entity 
    end
  end

  api :POST, "/patron/update_roles", "Modifica rolurile unui angajat in 1 companie"
  param :company_id, Integer, "Id-ul companiei", required: true
  param :user_id, Integer, "ID-ul angajatului obtinut din list_users", required: true 
  # param :roles, Array, "Categoriile de documente la care are acces", optional: true
  def update_roles
    @company = current_user.companies.find(params[:company_id])
    @company_user = @company.company_users.find_by(user_id: params[:user_id])
    if @company_user.nil?
      render json: {error: "User not found for this company"}, status: :not_found
      return
    end
    @company_user.meta_data ||= {}
    @company_user.meta_data[:categories] ||= (params[:roles] || [])
    if @company_user.save
      render json: @company_user.serialize
    else 
      render json: {errors: @company_user.errors}, status: :unprocessable_entity
    end
  end

  api :GET, "/patron/view_roles", "Vezi toate drepturile unui angajat in 1 companie"
  def view_roles
    @company = current_user.companies.find(params[:company_id])
    @company_user = @company.company_users.find_by(user_id: params[:user_id])
    if @company_user.meta_data.nil? || @company_user.meta_data.empty?
      roles = []
    else
      roles = @company_user.meta_data["categories"]
    end

    render json: { roles: roles }
  end

  private

  def company_params
    params.require(:company).permit(:name, :cui)
  end

  def authorize_user
    head 403 unless current_user.patron?
  end
end
