class WelcomeController < ApplicationController
  def index
    redirect_to activities_path unless  session[:access_token].nil?
  end
end