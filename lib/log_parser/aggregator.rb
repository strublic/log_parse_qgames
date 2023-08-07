module LogParser
  class Aggregator
    def initialize(entries)
      @entries = entries
    end

    def group
      @entries.each_with_object(AggregatorResult.new) do |entry, collection|
        collection[entry.name] ||= Accumulator.new
        collection[entry.name].add(entry)
      end
    end
  end
end