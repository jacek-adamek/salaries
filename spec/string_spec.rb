require_relative "../salaries"

describe "String" do
  describe "#to_ascii" do
    it "transcodes to ascii" do
      expect("ąćęłóńśżźĄĆĘŁÓŃŚŻŹ".to_ascii).to eq "acelonszzACELONSZZ"
    end
  end
end
