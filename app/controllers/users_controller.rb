class UsersController < ApplicationController
  before_action :authorize_user
  protect_from_forgery with: :null_session,
    if: Proc.new { |c| c.request.format =~ %r{application/json} }


    api :PUT, '/users/edit_account', 'Edit Account'
    # param :user_id, Integer, 'Id-ul utilizatorului'
    param :name, String, 'New Name'
    def edit_account
      my_user_id = params[:user_id].to_i

      if current_user.id != my_user_id
        render json: { message: 'You are not authorized to perform this action' }, status: :unauthorized
        return
      end

      myUser = User.find(my_user_id)
      if myUser.update_attribute(:name, params[:name])
        render json: { user: myUser.as_json(only: [:id, :name, :email, :role]) }
      else
        render json: { error: myUser.errors.full_messages.join(', ') }, status: :unprocessable_entity
      end
    end

    private

    def authorize_user
      head 403 unless (current_user.angajat? || current_user.patron? || current_user.angajat? || current_user.contabil_sef? || current_user.contabil?)
    end
end
