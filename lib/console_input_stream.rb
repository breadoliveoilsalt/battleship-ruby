require 'io/console'

class ConsoleInputStream

  attr_accessor :input_stream

  def initialize(input_stream: $stdin)
    @input_stream = input_stream
  end

  def read_line
    input_stream.gets.chomp
  end

  def read_char
    input_stream.getch
  end
  
end
