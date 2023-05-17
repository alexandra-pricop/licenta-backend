class Api::V1::DocumentsController < Api::V1::ApiController
  before_action :set_active_storage_host
  before_action :set_company
  before_action :authorize_user
  protect_from_forgery with: :null_session,
    if: Proc.new { |c| c.request.format =~ %r{application/json} }
  
  api :GET, "/companies/:company_id/documents/list_categories", "Listeaza categoriile de documente si rapoarte"
  def list_categories
    render json: {documents: Document::DOCUMENTS, reports: Document::REPORTS}
  end


  api :GET, "/companies/:company_id/documents/list_documents", "Listeaza documentele din cadrul unei companii"
  def list_documents
    company_user = current_user.company_user(@company)
    categories = company_user ? company_user.meta_data_categories : []
    # render json: @company.documents.where("author_id = ? OR category IN (?)", current_user.id, categories).map(&:serialize)
    render json: @company.documents.map(&:serialize)
  end

  api :GET, "/companies/:company_id/documents/list_reports", "Listează rapoartele din cadrul unei companii"
  def list_reports
    reports = @company.documents.where(category: Document::REPORTS)
    render json: reports.map(&:serialize)
  end


  api :GET, "/companies/:company_id/documents/list_reports_by_category", "Listează rapoartele dintr-o anumită categorie pentru o companie"
  param :category, String, 'Categoria tipului de document'
  # param :user_id, Integer, "ID-ul angajatului obtinut din list_users", required: true 
  def list_reports_by_category
    valid_categories = Document::REPORTS

    unless valid_categories.include?(params[:category])
      render json: { error: "Categoria specificată nu există" }, status: :unprocessable_entity
      return
    end

    @company_user = @company.company_users.find_by(user_id: params[:user_id])

    unless @company_user.meta_data["categories"].include?(params[:category])
      render json: { error: "Utilizatorul nu are permisiuni" }, status: :forbidden
      return
    end

    reports = @company.documents.where(category: params[:category])
    if reports.empty?
      render json: []
    else
      render json: reports.map(&:serialize)
    end
  end

  api :GET, "/companies/:company_id/documents/list_documents_by_issue_date", "Listeaza documentele din cadrul unei companii, introduse la o anumita data"
  param :issue_date, String, 'Data la care a fost introduse documentele'
  def list_documents_by_issue_date
    documents = @company.documents
    if params[:issue_date]
      issue_date = Date.parse(params[:issue_date]) # converteste data din string in formatul Date
      documents = @company.documents.where("EXTRACT(month FROM issue_date) = ? AND EXTRACT(year FROM issue_date) = ?", issue_date.month, issue_date.year)
    end
    render json: documents.map(&:serialize)
  end

  api :GET, "/companies/:company_id/documents/list_document", "Returneaza un document din cadrul unei companii"
  def list_document
    company_user = current_user.company_user(@company)
    categories = company_user ? company_user.meta_data_categories : []
    # render json: @company.documents.where("author_id = ? OR category IN (?)", current_user.id, categories).find(params[:document_id]).serialize
    render json: @company.documents.find(params[:document_id]).serialize
  end
  
  api :POST, "/companies/:company_id/documents/upload_document", "Incarca un document (sau raport) in cadrul unei companii"
  param :title, String, 'Titlul documentului', required: true
  param :description, String, 'Descrierea documentului'
  param :issue_date, String, 'Data documentului (2022-08-05)', required: true
  param :category, Document.categories.keys, 'Categoria documentului'
  param :file, ActionDispatch::Http::UploadedFile, 'Fisierul', required: true
  def upload_document
    @document = @company.documents.new(author_id: current_user.id, title: params[:title], description: params[:description], 
      issue_date: params[:issue_date], category: params[:category], file: params[:file])
    if @document.save
      render json: @document.serialize
    else
      render json: {errors: @document.errors}, status: :bad_request
    end
  end
  
  api :POST, "/companies/:company_id/documents/approve_document", "Rol contabil & contabil_sef: Aproba un document"
  # param :document_id, Integer, 'ID-ul unui document'
  def approve_document
    @document = @company.documents.document_nou.find(params[:document_id])
    if @document.update(status: 'document_aprobat')
      render json: @document.serialize
    else
      render json: @document.errors  
    end
  end

  api :DELETE, "/companies/:company_id/documents/remove_document", "Rol contabil & contabil_sef: Sterge un document"
  param :document_id, Integer, 'ID-ul unui document'
  def remove_document
    @document = @company.documents.find(params[:document_id])
    if @document.destroy
      head 204
    else
      render json: @document.errors  
    end
  end

  private

  def set_company
    @company = current_user.visible_companies.find_by(id: params[:company_id])
    head 403 unless @company
  end

  def authorize_user
    case action_name
    when 'approve_document', 'remove_document'
      head 403 unless current_user.contabil_sef? || current_user.contabil?
    end
  end

  # todo verifica daca e nevoie de setare in production
  def set_active_storage_host
    ActiveStorage::Current.host = 'http://localhost:3000' if ActiveStorage::Current.host.blank?
    true
  end
end
