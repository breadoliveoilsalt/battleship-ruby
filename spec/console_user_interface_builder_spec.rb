require_relative '../lib/console_user_interface_builder.rb'
require_relative '../lib/console_user_interface.rb'
require_relative '../lib/console_output_stream.rb'
require_relative '../lib/console_input_stream.rb'

describe ConsoleUserInterfaceBuilder do

  describe "#build" do

    it "returns an instance of ConsoleUserInterface with an input stream and an output stream" do
      user_interface = ConsoleUserInterfaceBuilder.build

      expect(user_interface).to be_a(ConsoleUserInterface)
      expect(user_interface.input_stream).to be_a(ConsoleInputStream)
      expect(user_interface.output_stream).to be_a(ConsoleOutputStream)
    end

  end

end
