class WelcomeController < ApplicationController
  def index
    redirect_to activities_path if cookies.encrypted[:access_token]
  end
end