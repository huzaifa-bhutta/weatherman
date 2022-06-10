module Arguments
  def get_arguments
    arguments = Array.new
    ARGV.each {|argv| arguments.push(argv)}
    return arguments
  end
end

