class AuthController < ApplicationController
  def index
    if params[:code]
      response = HTTParty.post("https://www.strava.com/api/v3/oauth/token", body: {
        client_id: ENV["CLIENT_ID"],
        client_secret: ENV["CLIENT_SECRET"],
        code: params[:code],
        grant_type: "authorization_code"
      })
      json = JSON.parse(response.body, object_class: OpenStruct)
      session[:access_token] = json.access_token

      puts JSON.parse(response.body, object_class: OpenStruct).athlete.inspect
      puts json.athlete.profile_medium

      session[:athlete_firstname] = json.athlete.firstname
      session[:athlete_lastname] = json.athlete.lastname
      session[:athlete_profile] = json.athlete.profile_medium

      redirect_to root_path
    else
      redirect_to  "https://www.strava.com/oauth/authorize?client_id=#{ENV["CLIENT_ID"]}&response_type=code&scope=activity:read_all&redirect_uri=#{ENV["REDIRECT_URI"]}&approval_prompt=force"
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end