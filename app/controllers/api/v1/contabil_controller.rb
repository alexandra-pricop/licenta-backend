require 'fcm'

class Api::V1::ContabilController < Api::V1::ApiController
  before_action :authorize_user
  protect_from_forgery with: :null_session,
    if: Proc.new { |c| c.request.format =~ %r{application/json} }

  api :GET, "/contabil/list_company_requests", "Rol contabil_sef: Listare cereri inregistrare companii in asteptare"
  def list_company_requests
    render json: Company.cerere.all.map(&:serialize)
  end

  api :POST, "/contabil/approve_company", "Rol contabil_sef: Aproba aplicatia unei companii"
  param :company_id, Integer, "ID Aplicatie companie"
  returns code: 204
  def approve_company
    @company = Company.cerere.find(params[:company_id])
    # @company_user = CompanyUser.find_by(company_id: params[:company_id])
    # if @company.update(status: 'aprobat') && @company_user.update(status: 'aprobat')
    @company.status = 'aprobat'    
    @company.company_users.build(user: current_user, status: "aprobat", meta_data: {"categories" => Document::REPORTS})

    if @company.save
      fcm_push_notification(@company)
      head 204
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  api :POST, "/contabil/reject_company", "Rol contabil_sef: Refuza inregistrarea unei companii"
  param :company_id, Integer, "ID Aplicatie companie"
  returns code: 204
  def reject_company
    @company = Company.cerere.find(params[:company_id])
    # @company_user = CompanyUser.find_by(company_id: params[:company_id])
    # if @company.update(status: 'refuzat') && @company_user.update(status: 'refuzat')
    if @company.update(status: 'refuzat')
      # Trimite notificare de push pentru patron
      fcm_push_notification(@company)
      head 204
    else
      render json: @company.errors, status: :unprocessable_entity
    end
    head :no_content
  end

  private

  def authorize_user
    head 403 unless current_user.contabil_sef?
  end

  def fcm_push_notification(company)
    firebase_server_key = "AAAA_xnnZsI:APA91bHHigg8O9j4Tr0kWYkm6wtzyEB_7QqMTrhZrpuBSoPTFTeeyUTdEUIeh_XaciIQKVBKv9voXtw4PQR1i22jbJbPK9KsDYTY2HI6X6Tp2TAjx7CuG9OiZwiPdQCtDVzfgxLJZLQl"
    fcm_client = FCM.new(firebase_server_key)
    message = "Cerere procesata pentru firma cu numele: #{company.name} si cuiul: #{company.cui}, statusul e: #{company.status}"
    image = nil
    options = { priority: 'high',
                data: { message: message, icon: image },
                notification: { 
                body: message,
                sound: 'default',
                icon: image,
                tag: 'status'
                }
              }
    # Vreau sa trimit doar catre patron, nu catre toti angajatii firmei, notificare
    patron_id = CompanyUser.where(company_id: company.id).pluck(:user_id).first
    # E un singur id, nu o lista, pt ca am considerat ca patron-ul e logat la
    # un anumit moment pe un singur telefon
    registration_id = User.find(patron_id).firebase_id
    response = fcm_client.send(registration_id, options)
    puts response
  end
end
