# frozen_string_literal: true

require_relative 'argv'
require_relative 'get_methods'
require_relative 'generate_reports'

class WeatherReport
  include Arguments
  include Reports
  def main
    case get_arguments[0]
    when '-e'
      generate_yearly_report
    when '-a'
      generate_average_report
    when '-c'
      generate_monthly_charts
    else
      p 'Your input is not right!'
    end
  end
end
WeatherReport.new.main
