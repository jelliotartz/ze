require 'rails_helper'

describe GenderDetector do
  let(:boy_text) { "boy" }
  let(:girl_text) { "girl" }
  let(:neutral_text) { "cabbage" }
  let(:unisex_text) { "actor" }
  let(:object) { { "text" => "Hillary", "type" => "Entity",
      "sentiment" => { "type" => "negative", "score" => "-0.738312" },
    } }

  let(:object2) { { "text" => "actor", "type" => "Entity",
      "sentiment" => { "type" => "negative", "score" => "-0.38312" },
    } }

  let(:transformed_object) { { "text" => "Hillary", "type" => "Entity",
      "sentiment" => { "type" => "negative", "score" => "-0.738312" }, "gender" => "female"
    } }

  let(:transformed_object2) { { "text" => "actor", "type" => "Entity",
      "sentiment" => { "type" => "negative", "score" => "-0.38312" }, "gender" => "neutral"
    } }

  describe "#detect_word" do

    it "returns 'neutral' by default" do
      expect(GenderDetector.detect_word(neutral_text)).to eq ("neutral")
    end

    it "returns 'male' when text is found in male_words array" do
      expect(GenderDetector.detect_word(boy_text)).to eq ("male")
    end

    it "returns 'female' when text is found in female_words array" do
      expect(GenderDetector.detect_word(girl_text)).to eq ("female")
    end

    it "returns 'unisex' when text is found in both arrays" do
      expect(GenderDetector.detect_word(unisex_text)).to eq ("neutral")
    end

    it "detects basic pluralization" do
      expect(GenderDetector.detect_word("boys")).to eq("male")
    end

  end

  describe "#detect_name" do
    it "returns 'male' for typically male name" do
      expect(GenderDetector.detect_name("patrick")).to eq ("male")
    end

    it "returns 'female' for typically female name" do
      expect(GenderDetector.detect_name("patricia")).to eq ("female")
    end

    it "returns 'unisex' for split name" do
      expect(GenderDetector.detect_name("morgan")).to eq ("neutral")
    end

    it "returns 'neutral' for name not in database" do
      expect(GenderDetector.detect_name("bobsled")).to eq ("neutral")
    end
  end

  describe "#detect" do
    it "returns 'male' for typically male name" do
      expect(GenderDetector.detect("patrick")).to eq ("male")
    end

    it "returns 'female' for typically female name" do
      expect(GenderDetector.detect("patricia")).to eq ("female")
    end

    it "returns 'unisex' for split name" do
      expect(GenderDetector.detect("morgan")).to eq ("neutral")
    end

    it "returns 'neutral' for name not in database" do
      expect(GenderDetector.detect("bobsled")).to eq ("neutral")
    end

    it "returns 'neutral' by default" do
      expect(GenderDetector.detect(neutral_text)).to eq ("neutral")
    end

    it "returns 'male' when text is found in male_words array" do
      expect(GenderDetector.detect(boy_text)).to eq ("male")
    end

    it "returns 'female' when text is found in female_words array" do
      expect(GenderDetector.detect(girl_text)).to eq ("female")
    end

    it "returns 'unisex' when text is found in both arrays" do
      expect(GenderDetector.detect(unisex_text)).to eq ("neutral")
    end
  end

  describe "#transform" do
    it "adds a gender key-value pair to a single object" do
      expect(GenderDetector.transform(object)).to eq(transformed_object)
    end


    it "object state is actually modified" do
      GenderDetector.transform(object)
      expect(object).to eq(transformed_object)
    end
  end

  describe "#transform_all" do
    it "adds gender key-value pairs to multiple objects" do
      objs = [object, object2]
      transformed_objs = [transformed_object, transformed_object2]
      GenderDetector.transform_all(objs)
      expect(objs).to eq(transformed_objs)
    end
  end

end
