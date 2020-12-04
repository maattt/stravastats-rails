module ApplicationHelper
  def km(meters)
    (meters / 1000).round(2)
  end

  def duration(seconds)
    hours = seconds / 3600
    minutes = (seconds % 3600) / 60
    seconds = seconds % 60
    if hours > 0
      return "#{hours}h#{minutes < 10 ? "0#{minutes}" : minutes}"
    else
      return "#{minutes}min"# #{seconds < 10 ? "0#{seconds}" : seconds}s"
    end
  end

  def svg(type)
    File.open("app/assets/images/#{type.downcase}.svg", "rb") do |file|
      raw file.read
    end
  end
end
