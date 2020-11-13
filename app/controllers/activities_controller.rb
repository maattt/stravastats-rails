class ActivitiesController < ApplicationController
  before_action :check_session

  def index
    @year = params[:year] ? params[:year].to_i : Date.today.year
    after = params[:year] ? Date.new(@year, 1, 1) : Date.new(Date.today.year, 1, 1)
    before = params[:year] ? Date.new(@year, 12, -1) : Date.new(Date.today.year, 12, -1)
    @activities = Strava.activities(session[:access_token], after, before).select { |a| ["Ride", "Run", "Swim"].include? a.type }

    respond_to do |format|
      format.html {}
      format.json {
        render json: { html: @activities.any? ? render_to_string(partial: 'year_section', formats: "html", locals: { activities: @activities, year: @year }) : "" }
      }
    end
  rescue
    respond_to do |format|
      format.html {
        redirect_to root_path
      }
      format.js {
        render plain: "errror"
      }
    end
  end

  private
  def check_session
    redirect_to root_path if session[:access_token].blank?
  end
end