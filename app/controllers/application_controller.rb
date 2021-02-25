class ApplicationController < ActionController::Base
  before_action :set_athlete

  def check_cookies
    redirect_to root_path if cookies.encrypted[:access_token].blank?
    
    if cookies.encrypted[:expires_at].to_i < DateTime.now.to_i
      response = HTTParty.post('https://www.strava.com/api/v3/oauth/token', body: {
                                 client_id: ENV['CLIENT_ID'],
                                 client_secret: ENV['CLIENT_SECRET'],
                                 refresh_token: cookies.encrypted[:refresh_token],
                                 grant_type: 'refresh_token'
                               })
      json = JSON.parse(response.body, object_class: OpenStruct)
      cookies.permanent.encrypted[:expires_at] = json.expires_at
      cookies.permanent.encrypted[:access_token] = json.access_token
      cookies.permanent.encrypted[:refresh_token] = json.refresh_token
    end
  end

  private

  def set_athlete
    if cookies.encrypted[:access_token] && session[:athlete_firstname].blank?
      athlete = Strava.athlete(cookies.encrypted[:access_token])
      session[:athlete_firstname] = athlete.firstname
      session[:athlete_lastname] = athlete.lastname
    end
  end
end
