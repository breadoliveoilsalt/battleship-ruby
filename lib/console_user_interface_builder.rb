require_relative './console_user_interface.rb'
require_relative './console_output_stream.rb'
require_relative './console_input_stream.rb'

class ConsoleUserInterfaceBuilder

  def self.build
    ConsoleUserInterface.new(
      output_stream: ConsoleOutputStream.new,
      input_stream: ConsoleInputStream.new
    )
  end

end
