require_relative "argv"
module Getter
  include Arguments
  def get_filenames()

    if Dir.exist?(get_arguments[2])
      return Dir.entries(get_arguments[2]).drop(2)
    else
      p "Wrong Directory or file"
    end
  end

  def get_year_month()
    get_arguments[1].split("/")
  end

  def get_month_name(full_date)
    date_readable = full_date.split("-")
    month = date_readable[1]
    day = date_readable[2]
    month_name = ""
    months = ["January","Febuary", "March","April", "May", "June", "July", "August", "September", "October", "November", "December"]
    months.each_with_index do |elem, index|
      if index + 1==Integer(month)
        month_name = elem
      end
    end
    return "#{month_name} #{day}"
  end
  def get_input_year_filenames()
    year = get_year_month[0]
    filenames_with_input_year = get_filenames.select {|file| file.include?(year)}
    return filenames_with_input_year
  end
  def get_preprocessed_data(file)
    data_reading = Array.new
    file.each do |line|
      next if !line.include?(",")
      data_reading.push(line)
    end
    return data_reading.slice(1..data_reading.length)
  end

end
