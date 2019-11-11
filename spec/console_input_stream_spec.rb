require_relative '../lib/console_input_stream.rb'

require 'io/console'

describe ConsoleInputStream do

  let(:user_input) { ConsoleInputStream.new }

  describe "#read_line" do

    it "returns a string corresponding to user input from $stdin" do
      mock_input = "I, the user, typed this in"

      allow($stdin).to receive(:gets).and_return(mock_input)
      
      expect(user_input.read_line).to eq(mock_input)
    end

  end

  describe "read_char" do 

    it "returns a single character entered from the keyboard without requiring the user to hit enter" do
      allow($stdin).to receive(:getch).and_return("1")

      expect(user_input.read_char).to eq("1")
    end

  end

end
