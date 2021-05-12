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

  def self.distances_per_months(token, year, type)
    distances_per_months = { "Ride" => {}, "Run" => {}, "Swim" => {} }

    activities = self.activities(token, Date.new(year, 1, 1), Date.new(year, 12, 31))
    (1..12).map do |month|
      distances_per_months.keys.each do |t|
        distances_per_months[t][month] ||= 0
      distances_per_months[t][month] += activities.select { |a| a.type == t && DateTime.parse(a.start_date).month == month }.sum(&:distance)
      end
    end
    return distances_per_months
  end

  def self.athlete(token)
    response = HTTParty.get("https://www.strava.com/api/v3/athlete", headers: {
      Authorization: "Bearer #{token}"
    })
    JSON.parse(response.body, object_class: OpenStruct)
  end
end