class Api::V1::AngajatController < Api::V1::ApiController
    before_action :authorize_user
    
    api :POST, '/angajat/join_company', 'Rol angajat: Angajatul aplica la o companie'
    param :cui, String, 'CUI'
    returns code: 204, desc: "no content"
    error code: 400, desc: "Bad Request",  meta: {errors: 'Validation errors'}
    def join_company
      company = Company.find_by(cui: params[:cui])
      return render json: {errors: {company: 'not found'}}, status: :unprocessable_entity unless company
      company_user = current_user.company_users.new(company: company)
      if company_user.save
        head :no_content
      else
        render json: company_user.errors, status: 400
      end
    end

    api :GET, '/angajat/list_requests', 'Rol angajat: Listeaza aplicatiile in companii in asteptare'
    def list_requests
       render json: current_user.company_users.cerere.map(&:serialize)
    end


    private
   
    def authorize_user
        head 403 unless current_user.angajat?
    end
end