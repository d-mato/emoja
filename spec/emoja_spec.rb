RSpec.describe Emoja do
  it "has a version number" do
    expect(Emoja::VERSION).not_to be nil
  end

  describe :translate do
    subject { Emoja.translate("🍎食べたい") }
    it { is_expected.to eq "赤リンゴ食べたい" }
  end

  describe :search do
    subject { Emoja.search("猫") }
    it { is_expected.to eq ["😺", "😸", "😹", "😻", "😼", "😽", "🙀", "😿", "😾", "🐱", "🐈", "🐾"] }
  end
end
