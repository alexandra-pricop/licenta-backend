class Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json
    protect_from_forgery with: :null_session,
      if: Proc.new { |c| c.request.format =~ %r{application/json} }
    # before_action :authenticate_user!, except: [:new, :create]
    before_action :configure_sign_up_params, only: [:create]

    resource_description do
      api_base_url ''
    end

    api :POST, '/users', 'Inregistrare cont'
    param :user, Hash, :required => true do
      param :name, String, 'Name of a :resource', required: true
      param :email, String, 'Email', required: true
      param :password, String, 'Password', required: true
      param :role, ['patron', 'angajat'], 'Role', required: true
    end
    error code: 400, desc: "Bad Request",  meta: {errors: 'Validation errors'}
    returns code: 200, desc: "a successful response"
    def create
      super
    end

    protected

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
    end

    private
    
    def respond_with(resource, _opts = {})
      resource.persisted? ? register_success : register_failed(resource)
    end

    def register_success
      head :ok
    end

    def register_failed(resource)
      render json: { errors: resource.errors }, status: 400
    end
end