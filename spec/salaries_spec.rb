require_relative "../salaries"

describe "salaries" do
  describe "#people_working_times" do
    let(:people) { people = ['John Doe', "John Wayne"] }
    let(:summary) { [['John Doe', "123:12:00"], ["John Wayne", "83:45:00"]] }

    it "returns decimal representation of working times" do
      result = people_working_times(people, summary)
      expect(result).to eq([123.2, 83.75])
    end

    it "returns error messages when there is no summary data for person" do
      people << "James Bond"
      result = people_working_times(people, summary)
      expect(result).to eq([123.2, 83.75, 'James Bond data not found.'])
    end

    it "returns an error when there is time conversion error" do
      summary[1][1] = "d11xxd123"
      result = people_working_times(people, summary)
      expect(result).to eq([123.2, 'Time conversion error.'])
    end
  end
end
