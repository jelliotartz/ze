require 'rails_helper'

describe MetricsCalculator do
  let(:hillary) { Keyword.new(text: "Hillary", sentiment_type: "negative", sentiment_score: -0.5, gender: "female") }
  let(:nancy) { Keyword.new(text: "Nancy", sentiment_type: "negative", sentiment_score: -0.7, gender: "female") }
  let(:jeb ) { Keyword.new(text: "Jeb", sentiment_type: "negative", sentiment_score: -0.0, gender: "male") }
  let(:donald) { Keyword.new(text: "Donald", sentiment_type: "negative", sentiment_score: -0.4, gender: "male") }
  let(:foo) { Keyword.new(text: "Foo", sentiment_type: "positive", sentiment_score: 1.0, gender: "neutral") }
  let(:bar) { Keyword.new(text: "Bar", sentiment_type: "positive", sentiment_score: 0.0, gender: "neutral") }
  let(:keywords) { [hillary, nancy, jeb, donald, foo, bar] }
  let(:calculator) { MetricsCalculator.new(keywords) }

describe "#keywords_average" do
  it "returns an average sentiment score for a group of keywords" do
    expect(calculator.keywords_average([hillary,nancy])).to eq(-0.6)
  end
end

describe "#return_averages_by_gender" do
  it "returns a hash of averages" do
    expect(calculator.return_averages_by_gender).to be_kind_of(Hash)
  end

  it "contains the average female sentiment" do
    expect(calculator.return_averages_by_gender.key?("female")).to be true
  end

  it "calulates the average female sentiment" do
    expect(calculator.return_averages_by_gender["female"]).to eq(-0.6)
  end

  it "contains the average male sentiment" do
    expect(calculator.return_averages_by_gender.key?("male")).to be true
  end

  it "calulates the average male sentiment" do
    expect(calculator.return_averages_by_gender["male"]).to eq(-0.2)
  end

  it "contains the average neutral sentiment" do
    expect(calculator.return_averages_by_gender.key?("neutral")).to be true
  end

  it "calulates the average neutral sentiment" do
    expect(calculator.return_averages_by_gender["neutral"]).to eq(0.5)
  end

end

end
