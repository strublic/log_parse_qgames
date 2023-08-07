RSpec.describe LogParser::FileReader do
  let(:reader) { described_class.new(path) }
  let(:path) { File.expand_path("../fixtures/lines.log", __FILE__) }

  describe "#lines" do
    subject(:lines) { reader.lines }

    let(:expected_lines) { ["line 1", "line 2", "line 3"] }

    it { is_expected.to eql(expected_lines) }

    context "with invalid path" do
      let(:path) { "missing.log" }

      it "raises error" do
        expect { lines }.to raise_error(LogParser::Error)
      end
    end
  end
end