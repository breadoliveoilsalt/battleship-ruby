class ConsoleOutputStream

  attr_accessor :output_stream

  def initialize(output_stream: $stdout)
    @output_stream = output_stream
  end

  def render(str)
    output_stream.puts(str)
  end

end
