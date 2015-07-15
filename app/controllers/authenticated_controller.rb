require 'rails_api_auth/authentication'

class AuthenticatedController < ApplicationController

  include RailsApiAuth::Authentication

  before_action :authenticate!

  def index
    render json: { success: true }
  end

end
