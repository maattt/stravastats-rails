class AuthController < ApplicationController
  def index
    # if session[:access_token]
    #   redirect_to activities_path
    # else
      if params[:code]
        response = HTTParty.post("https://www.strava.com/api/v3/oauth/token", body: {
          client_id: ENV["CLIENT_ID"],
          client_secret: ENV["CLIENT_SECRET"],
          code: params[:code],
          grant_type: "authorization_code"
        })
        session[:access_token] = JSON.parse(response.body, object_class: OpenStruct).access_token
        redirect_to root_path
      else
        redirect_to  "https://www.strava.com/oauth/authorize?client_id=#{ENV["CLIENT_ID"]}&response_type=code&scope=activity:read_all&redirect_uri=#{REDIRECT_URI}&approval_prompt=force"
      end
    # end
  end
end