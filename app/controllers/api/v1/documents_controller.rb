class Api::V1::DocumentsController < Api::V1::ApiController
  before_action :set_company
  # before_action :authorize_user
  
  
  api :GET, "/companies/:company_id/documents/list_categories", "Listeaza categoriile de documente si rapoarte"
  def list_categories
    render json: {documents: Document::DOCUMENTS, reports: Document::REPORTS}
  end


  api :GET, "/companies/:company_id/documents/list_documents", "Listeaza documentele din cadrul unei companii"
  def list_documents
    categories = current_user.company_user(@company).meta_data_categories
    render json: @company.documents.where("author_id = ? OR category IN (?)", current_user.id, categories).map(&:serialize)
  end

  api :GET, "/companies/:company_id/documents/list_document", "Returneaza un document din cadrul unei companii"
  param :document_id, Integer, 'ID-ul unui document'
  def list_document
    categories = current_user.company_user(@company).meta_data_categories
    render json: @company.documents.where("author_id = ? OR category IN (?)", current_user.id, categories).find(params[:document_id]).serialize
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
  param :document_id, Integer, 'ID-ul unui document'
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
end
