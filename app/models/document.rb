# == Schema Information
#
# Table name: documents
#
#  id          :bigint           not null, primary key
#  company_id  :bigint           not null
#  author_id   :integer
#  title       :string
#  category    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  file        :string
#  status      :integer          default("document_nou")
#  description :string
#  issue_date  :date
#
class Document < ApplicationRecord
  belongs_to :company

  enum category: {
    facturi_clienti: 0, facturi_furnizori: 1, bonuri_achizitie: 2, chitante_clienti: 3, chitante_furnizori: 4, extrase_de_cont: 5, alte_documente: 6,
    balanta_de_verificare_contabila: 10, registru_jurnal: 11, carte_mare: 12, jurnal_vanzari: 13, jurnal_cumparari: 14, balanta_clienti: 15, 
    balanta_furnizori: 16, registru_de_casa: 17, extras_de_banca: 18, alte_rapoarte: 19
    }

  enum status: [:document_nou, :document_aprobat]

  DOCUMENTS = %w(facturi_clienti facturi_furnizori bonuri_achizitie chitante_clienti chitante_furnizori extrase_de_cont alte_documente)
  REPORTS = Document.categories.keys - DOCUMENTS

  has_one_attached :file

  validates_presence_of :category

  def acceptable_file_size?
    return unless file.attached?
    return unless file.byte_size > 1.megabyte
    errors.add :file, "trebuie sa fie mai mica de 1MB"
  end

  def serialize
    result = self.as_json(only: [:id, :title, :description, :issue_date, :category, :status])
    result[:file] = self.file.url if self.file.attached?
    result
  end

end

