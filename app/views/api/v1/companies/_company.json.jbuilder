json.extract! company, :id, :name, :cui, :status, :created_at, :updated_at
json.url api_v1_company_url(company, format: :json)
