require 'rails_helper'

describe APICoordinator do

  #not testing the API call so we don't waste any credits
  let(:params) { params[:sample][:content] = "Susan likes bikes" }
  let(:caller) { APICoordinator.new(params)}

  describe "#create_sample" do

    it "adds nothing when given empty response array" do
      caller.create_sample
      expect(sample.keywords.empty?).to be(true)
    end

    it "adds keyword objects to sample when response given" do
      caller.response = {"keywords" => [{'text' => "Susan", 'gender' => "female", 'sentiment' => { 'score' => 0.5, 'type' => "positive" } }] }
      caller.convert_to_keyword_objects

      expect(sample.keywords.first).to have_attributes(text: "Susan", gender: "female", sentiment_type: "positive", sentiment_score: 0.5)
    end

  end


end
