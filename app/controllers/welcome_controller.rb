class WelcomeController < ApplicationController
  def index
    if cookies.encrypted[:access_token]
      athlete = Strava.athlete(cookies.encrypted[:access_token])
      session[:athlete_firstname] = athlete.firstname
      session[:athlete_lastname] = athlete.lastname
      redirect_to activities_path
    end
  end
end