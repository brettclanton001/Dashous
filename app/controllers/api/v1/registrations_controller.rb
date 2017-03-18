class Api::V1::RegistrationsController < ApplicationController

  def create
    user = User.new(sign_up_params)

    if user.save
      render json: {}, status: 201
    else
      render json: user.errors, status: 400
    end
  end

  private

  def sign_up_params
    params.require(:user)
      .permit(:username, :email, :password, :password_confirmation, :terms_and_conditions)
      .merge(currency: 'usd')
  end
end
