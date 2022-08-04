class Api::V1::IndexController < Api::V1::ApiController
    def index
        render json: {success: true}
    end
end