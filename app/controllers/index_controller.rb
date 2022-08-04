class IndexController < Api::V1::ApiController
    def index
        render plain: "Conta Backend"
    end
end