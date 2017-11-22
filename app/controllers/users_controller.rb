# controls requests regarding to the user
class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create

  # POST /signup
  # return authenticated token upon signup
  def create
    user = User.create!(user_create_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  # GET /user
  def user
    clean_user(current_user)
  end

  # GET /users
  def users
    users = User.paginate(page: params[:page], per_page: 20)
    clean_user(users)
  end

  def update_password
    return json_response({ message: Message.password_confirmation_missing }, :bad_request) unless params['password_confirmation']
    return json_response({ message: Message.password_confirmation_mismatch}, :bad_request) if params['password'] != params['password_confirmation']
    current_user.update(user_password_params)
    json_response({ message: Message.password_updated })
  end

  private

  def user_create_params
    params.permit(
      :name,
      :lastname,
      :email,
      :dateofbirth,
      :password,
      :password_confirmation
    )
  end

  def user_password_params
    params.permit(
      :email,
      :password,
      :password_confirmation
    )
  end

  def clean_user(object)
    json_response(object, :ok, %w[id password_digest updated_at])
  end
end
