# frozen_string_literal: true

module Arguments
  def get_arguments
    arguments = []
    ARGV.each { |argv| arguments.push(argv) }
    arguments
  end
end
