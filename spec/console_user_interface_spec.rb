require_relative '../lib/console_user_interface.rb'

describe ConsoleUserInterface do

  describe "#new" do

    it "requires an output_stream and input_stream to be passed in as keyword arguments" do
      expect { ConsoleUserInterface.new }.to raise_error(ArgumentError)
    end

  end


end
