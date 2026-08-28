# frozen_string_literal: true

RSpec.describe Emoja do
  it "has a version number" do
    expect(Emoja::VERSION).not_to be nil
  end

  describe :translate do
    subject { Emoja.translate(text) }

    context "with a single codepoint emoji" do
      let(:text) { "🍎食べたい" }
      it { is_expected.to eq "赤リンゴ食べたい" }
    end

    context "with a ZWJ sequence" do
      let(:text) { "🐈‍⬛が好き" }
      it { is_expected.to eq "黒猫が好き" }
    end

    context "with a flag" do
      let(:text) { "🇯🇵に住む" }
      it { is_expected.to eq "日本に住む" }
    end

    context "with a variation selector" do
      let(:text) { "❤️" }
      it { is_expected.to eq "赤いハート" }
    end

    context "with a skin tone modifier" do
      let(:text) { "👍🏽" }
      it { is_expected.to eq "サムズアップ" }
    end

    context "with an emoji the dictionary does not know" do
      let(:text) { "👨‍👩‍👧‍👦と暮らす" }
      it { is_expected.to eq "👨‍👩‍👧‍👦と暮らす" }
    end
  end

  describe :search do
    subject { Emoja.search("猫") }
    it { is_expected.to eq ["😺", "😸", "😹", "😻", "😼", "😽", "🙀", "😿", "😾", "🐱", "🐈", "🐈‍⬛", "🐾"] }
  end

  describe :include_emoji? do
    subject { Emoja.include_emoji?(text) }

    context "with a ZWJ sequence" do
      let(:text) { "🐈‍⬛" }
      it { is_expected.to be true }
    end

    context "with a skin tone modifier" do
      let(:text) { "👍🏽" }
      it { is_expected.to be true }
    end

    context "without an emoji" do
      let(:text) { "文字だけ" }
      it { is_expected.to be false }
    end
  end
end
