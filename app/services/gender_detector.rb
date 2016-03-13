require 'csv'
require_relative 'gender_detector_assets/male_words'
require_relative 'gender_detector_assets/female_words'

module GenderDetector


  def self.transform(keywords_hash)
    keywords_hash["gender"] = self.detect(keywords_hash["text"])
    keywords_hash
  end

  def self.transform_all(keywords_hashes)
    keywords_hashes.map {|hash| self.transform(hash)}
  end

  def self.detect(text)
    outcome = self.detect_word(text)
    if outcome == "neutral"
      return self.detect_name(text)
    else
      return outcome
    end
  end

  def self.matches?(regex_list, text)
    regex_list.any? { |regex| regex.match(text) }
  end

  def self.detect_word(text)

    in_male = self.matches?(MALE_WORDS, text.downcase)
    in_female = self.matches?(FEMALE_WORDS, text.downcase)

    if in_female && in_male
      "unisex"
    elsif in_male
      "male"
    elsif in_female
      "female"
    else
      "neutral"
    end

  end

  def self.detect_name(text)

    unisex_threshold = 0.6

    response = Guess.gender(text)

    percentage = response[:confidence]
    gender = response[:gender]

    if gender == "unknown"
      return "neutral"
    elsif percentage < unisex_threshold && percentage > 1 - unisex_threshold
      return "unisex"
    else percentage
      return gender
    end
  end

end
