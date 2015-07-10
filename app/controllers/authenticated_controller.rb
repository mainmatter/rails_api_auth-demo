require 'rails_api_auth/authentication'

class AuthenticatedController < ApplicationController

  include RailsApiAuth::Authentication

  before_action :authenticate!

  def index
    render text: "FB uid #{current_login.facebook_uid} is logged in"
  end

end
