# frozen_string_literal: true

require_relative 'get_methods'
require_relative 'argv'
require 'colorize'
module Reports
  include Getter
  include Arguments
  def generate_average_report
    file = File.open(get_arguments[2], 'r')
    highest_average_list = []
    lowest_average_list = []
    humidity_average_list = []
    get_preprocessed_data(file).each do |line|
      daily_data = (line.chomp).split(',')
      highest_average_list.push(Integer(daily_data[1].nil? ? '0' : daily_data[1]))
      lowest_average_list.push(Integer(daily_data[3].nil? ? '0' : daily_data[3]))
      humidity_average_list.push(Integer(daily_data[8].nil? ? '0' : daily_data[8]))
    end
    highest_average = highest_average_list.inject(0) { |sum, el| sum + el } / highest_average_list.size
    lowest_average = lowest_average_list.inject(0) { |sum, el| sum + el } / lowest_average_list.size
    humidity_average = humidity_average_list.inject(0) { |sum, el| sum + el } / humidity_average_list.size
    puts "Highest Average: #{highest_average}C\nLowest Average: #{lowest_average}C\nAverage Humidity:#{humidity_average}%"
  end

  def generate_yearly_report
    dir = get_arguments[2]
    yearly_highest_list = []
    yearly_lowest_list = []
    yearly_humidity_list = []
    get_input_year_filenames.each do |filename|
      file = File.open("#{dir}/#{filename}", 'r')
      monthly_highest = []
      monthly_lowest = []
      monthly_humidity = []
      daily_data = []
      file.each do |line, _index|
        next unless line.include?(',')

        daily_data.push((line.chomp).split(','))
      end
      daily_data.each_with_index do |elem, index|
        next if index.zero?

        monthly_highest.push(Array[elem[0], Integer(elem[1] == '' ? '0' : elem[1])])
        monthly_lowest.push(Array[elem[0], Integer(elem[3] == '' ? '0' : elem[3])])
        monthly_humidity.push(Array[elem[0], Integer(elem[7] == '' ? '0' : elem[7])])
      end
      yearly_highest_list.push(monthly_highest.max { |a, b| a[1] <=> b[1] })
      yearly_lowest_list.push(monthly_lowest.min { |a, b| a[1] <=> b[1] })
      yearly_humidity_list.push(monthly_humidity.max { |a, b| a[1] <=> b[1] })
    end
    high_temp = yearly_highest_list.max { |a, b| a[1] <=> b[1] }
    low_temp = yearly_lowest_list.min { |a, b| a[1] <=> b[1] }
    most_humidity = yearly_humidity_list.max { |a, b| a[1] <=> b[1] }
    p "Highest: #{high_temp[1]}C on #{get_month_name(high_temp[0])}"
    p "Lowest: #{low_temp[1]}C on #{get_month_name(low_temp[0])}"
    p "Most Humidity: #{most_humidity[1]}% on #{get_month_name(most_humidity[0])}"
  end

  def generate_monthly_charts
    file = File.open(get_arguments[2], 'r')
    highest_average_list = []
    lowest_average_list = []
    get_preprocessed_data(file).each do |line|
      daily_data = (line.chomp).split(',')
      highest_average_list.push(Integer(daily_data[1].nil? ? '0' : daily_data[1]))
      lowest_average_list.push(Integer(daily_data[3].nil? ? '0' : daily_data[3]))
    end
    max_min = highest_average_list.zip(lowest_average_list)
    max_min.each_with_index do |temp, index|
      print "#{index + 1} "
      temp[1].times { print '+'.blue }
      temp[0].times { print '+'.red }
      print " #{temp[1]}C - #{temp[0]}C"
      puts "\n"
    end
  end
end
