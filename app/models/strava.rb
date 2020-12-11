class Strava
  def self.activities(token, after, before, per_page = 200)
    count = per_page
    page = 1
    activities = []
    while count == per_page do
      response = HTTParty.get("https://www.strava.com/api/v3/athlete/activities", body: {
        after: after.to_time.to_i,
        before: before.to_time.to_i,
        per_page: per_page,
        page: page
      }, 
      headers: {
        Authorization: "Bearer #{token}"
      })
      throw Exception if response.code == 401
     data = JSON.parse(response.body, object_class: OpenStruct)
     count = data.length
     page += 1
     activities += data
   end
   activities
  end

  def self.athlete(token)
    response = HTTParty.get("https://www.strava.com/api/v3/athlete", headers: {
      Authorization: "Bearer #{token}"
    })
    JSON.parse(response.body, object_class: OpenStruct)
  end
end