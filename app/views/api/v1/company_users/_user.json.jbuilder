json.extract! user, :id, :name, :email, :role, :created_at, :updated_at
json.has_access @company.users.find_by(id: user.id).present?
json.url api_v1_user_url(user, format: :json)
