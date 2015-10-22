require_relative "../salaries"

describe "String" do
  describe "#to_ascii" do
    it "transcode to ascii" do
      expect("ąćęłóńśżź".to_ascii).to eq "acelonszz"
    end
  end
end
