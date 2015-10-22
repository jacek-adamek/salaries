require_relative "../salaries"

describe "salaries" do
  let(:people_file) { File.join(__dir__, "test_files/people.txt") }
  let(:csv_file) { File.join(__dir__, "test_files/summary.csv") }
  let(:output_file) { File.join(__dir__, "test_files/output.txt") }

  describe "#people_working_times" do
    let(:people) { people = ['John Doe', "John Wayne"] }
    let(:csv_data) { [['John Doe', "123:12:00"], ["John Wayne", "83:45:00"]] }

    it "returns decimal representation of working times" do
      result = people_working_times(people, csv_data)
      expect(result).to eq([123.2, 83.75])
    end

    it "returns error messages when there is no csv data data for person" do
      people << "James Bond"
      result = people_working_times(people, csv_data)
      expect(result).to eq([123.2, 83.75, 'James Bond data not found.'])
    end

    it "returns an error when there is time conversion error" do
      csv_data[1][1] = "d11xxd123"
      result = people_working_times(people, csv_data)
      expect(result).to eq([123.2, 'Time conversion error.'])
    end
  end

  describe "#read_csv" do
    it "returns csv_data data" do
      csv_data = read_csv(csv_file)
      expect(csv_data).to eq([
        ["Józef Zajączek", "112:01:00"],
        ["Jan Kowalski", "110:55:00"]])
    end

    it "raises exception when file does not exist" do
      expect { read_csv("asassa") }.to raise_error(StandardError)
    end
  end

  describe "#read_people" do
    it "returns people list" do
      people = read_people(people_file)
      expect(people).to eq(["Jan Kowalski", "James Bond", "Józef Zajączek"])
    end

    it "raises exception when file does not exist" do
      expect { read_people("asassa") }.to raise_error(StandardError)
    end
  end

  describe "#time_string_to_number" do
    it "converts time string to decimal number" do
      expect(time_string_to_number("123:13:00")).to eq(123.22)
    end

    it "raises exception when invalid data was given" do
      expect { time_string_to_number("a23:13:00") }.to raise_error(ArgumentError)
    end
  end

  describe "#run" do
    before do
      allow(ARGV).to receive(:size) { 3 }
      allow(ARGV).to receive(:shift).and_return(csv_file, people_file, output_file)
    end

    after do
      if File.exists?(output_file)
        FileUtils.rm(output_file)
      end
    end

    it "creates output file" do
      run
      expect(File.exists?(output_file)).to be true
    end

    it "creates output file" do
      run
      result = File.read(output_file)
      expect(result).to eq <<-STR
110.92
James Bond data not found.
112.02
STR
    end
  end
end
