class Api::V1::ContabiliController < Api::V1::ApiController
  before_action :set_user, only: %i[ show update destroy ]
  before_action :authorize_user

  api :GET, '/contabili', 'Admin role: Listare contabili din aplicatie'
  def index
    @users = User.where(role: ['contabil_sef', 'contabil'])
  end

  api :GET, '/contabili/:id', 'Admin role: Detalii pentru 1 contabil'
  param :id, :number, required: true, desc: 'id of the requested contabil'
  def show
  end

  api :POST, '/contabili', 'Admin role: Adaugare contabil'
  param :user, Hash, :required => true do
    param :name, String, 'Name of a :resource', required: true
    param :email, String, 'Email', required: true
    param :password, String, 'Password', required: true
    param :role, ['contabil_sef', 'contabil'], 'Role', required: true
  end
  def create
    @user = User.new(user_params)

    if @user.save
      render :show, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  api :PUT, '/contabili/:id', 'Admin role: Modificare contabil'
  param :user, Hash, :required => true do
    param :name, String, 'Name of a :resource', required: true
    param :email, String, 'Email', required: true
    param :role, ['contabil_sef', 'contabil'], 'Role', required: true
  end
  def update
    if @user.update(user_params)
      render :show, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/contabili/:id', 'Admin role: Sterge un contabil'
  def destroy
    @user.destroy
    head :no_content
  end

  private

  def authorize_user
    head 403 unless current_user.admin?
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :role)
  end
end
