class Api::V1::Authentication::SessionsController < ApplicationController

  def create
    service = ::Authentication::LoginService.new(params)

    if service.authenticated?
      warden.set_user service.user
      flash[:notice] = "Signed in successfully."
      render json: {}, status: 204
    else
      render json: {}, status: 401
    end
  end
end
