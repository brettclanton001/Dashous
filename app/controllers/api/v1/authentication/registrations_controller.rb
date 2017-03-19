class Api::V1::Authentication::RegistrationsController < ApplicationController

  def create
    service = ::Authentication::AccountService.new(params)

    if service.create!
      render json: {}, status: 201
    else
      render json: service.errors, status: 400
    end
  end
end
