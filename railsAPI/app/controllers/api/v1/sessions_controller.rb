class Api::V1::SessionsController < ApplicationController

  def create
    user_info = params.require(:session).permit(:email, :password)
    user = user_info[:email].present? && User.find_by(email: user_info[:email])

    return head :not_found unless user
    if user.valid_password?(user_info[:password])
      render json: {id: user.id, auth_token: user.auth_token}, status: :ok
    else
      render json: {errors: "Invalid email or password"}, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find_by(auth_token: params[:id])
    return head :not_found if user.blank?
    user.generate_authentication_token!
    user.save
    head :no_content
  end
end
