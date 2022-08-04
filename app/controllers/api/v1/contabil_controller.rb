class Api::V1::ContabilController < Api::V1::ApiController
  before_action :authorize_user

  api :GET, "/contabil/list_company_requests", "Rol contabil_sef: Listare cereri inregistrare companii in asteptare"
  def list_company_requests
    render json: Company.cerere.all.map(&:serialize)
  end

  api :POST, "/contabil/approve_company", "Rol contabil_sef: Aproba aplicatia unei companii"
  param :company_id, Integer, "ID Aplicatie companie"
  returns code: 204
  def approve_company
    @company = Company.cerere.find(params[:company_id])
    if @company.update(status: 'aprobat')
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
    @company.destroy
    head :no_content
  end

  private

  def authorize_user
    head 403 unless current_user.contabil_sef?
  end
end
