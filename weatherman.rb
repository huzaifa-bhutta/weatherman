require_relative 'argv'
require_relative 'get_methods'
require_relative 'generate_reports'


class WeatherReport
  include Arguments
  include Reports
  def main
    if get_arguments[0] == "-e"
      generate_yearly_report
    elsif get_arguments[0]=="-a"
      generate_average_report
    elsif get_arguments[0] == "-c"
      generate_monthly_charts
    else
      p "Your input is not right!"
    end
  end
end
WeatherReport.new.main

