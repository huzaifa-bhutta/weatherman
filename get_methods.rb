# frozen_string_literal: true

require_relative 'argv'
module Getter
  include Arguments
  def get_filenames
    if Dir.exist?(get_arguments[2])
      Dir.entries(get_arguments[2]).drop(2)
    else
      p 'Wrong Directory or file'
    end
  end

  def get_year_month
    get_arguments[1].split('/')
  end

  def get_month_name(full_date)
    date_readable = full_date.split('-')
    month = date_readable[1]
    day = date_readable[2]
    month_name = ''
    months = %w[January Febuary March April May June July August September October
                November December]
    months.each_with_index do |elem, index|
      month_name = elem if index + 1 == Integer(month)
    end
    "#{month_name} #{day}"
  end

  def get_input_year_filenames
    year = get_year_month[0]
    get_filenames.select { |file| file.include?(year) }
  end

  def get_preprocessed_data(file)
    data_reading = []
    file.each do |line|
      next unless line.include?(',')

      data_reading.push(line)
    end
    data_reading.slice(1..data_reading.length)
  end
end
