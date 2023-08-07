module LogParser
  class Parser
    def initialize(input, options ={})
      @input = input

      @formatter = options[:formatter] || Formatter
      @tokenizer = options[:tokenizer] || Tokenizer
      @reader = options[:reader] || FileReader
    end

    def format
      @formatter.new(aggregated_data).format
    end

    private

    def aggregated_data
      Aggregator.new(tokenized_data).group
    end

    def tokenized_data
      @tokenizer.new(read_data).entries
    end

    def read_data
      @reader.new(@input).lines
    end
  end
end