class Users::SessionsController < Devise::SessionsController
    respond_to :json
    protect_from_forgery with: :null_session,
      if: Proc.new { |c| c.request.format =~ %r{application/json} }

    resource_description do
      api_base_url ''
    end

    api :POST, '/users/sign_in', 'Login'
    param :user, Hash, :required => true do
      param :email, String, 'Email', required: true
      param :password, String, 'Password', required: true
    end
    error code: 401, desc: "Unauthorized"
    returns code: 200, desc: "a successful response" do
      property :user, Hash, "An object" do
        property :id, Integer, "An integer value"
        property :name, String, "A string value"
        property :email, String, "A string value"
        property :role, User.roles.keys, "One of 2 possible string values"
      end
    end
    def create
      super
    end
    
    api :DELETE, '/users/sign_out', 'Logout'
    returns code: 200, desc: "a successful response"
    def destroy
      super
    end

    private
    
    def respond_with(resource, _opts = {})
      # head :ok
      render json: {user: resource.as_json(only: [:id, :name, :email, :role])}
    end
    
    def respond_to_on_destroy
      log_out_success
    end
    
    def log_out_success
      head :ok
    end
end