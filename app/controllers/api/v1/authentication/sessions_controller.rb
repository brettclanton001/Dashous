class Api::V1::Authentication::SessionsController < ApplicationController

  def create
    service = ::Authentication::LoginService.new(params)

    if service.authenticated?
      service.create_session
      render json: {}, status: 204
    else
      render json: {}, status: 401
    end
  end
end
