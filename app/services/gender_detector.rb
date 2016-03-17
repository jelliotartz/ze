require 'csv'
# require_relative 'gender_detector_assets/male_words'
# require_relative 'gender_detector_assets/female_words'

module GenderDetector

FEMALE_WORDS=[
/\bactor\b/,
/\bactress(es)?\b/,
/\baunts?\b/,
/\bbrides?\b/,
/\bchairwoman\b/,
/\bdaughters?\b/,
/\bfemales?\b/,
/\bfiancees?\b/,
/\bgirls?\b/,
/\bgirlfriends?\b/,
/\bgoddess(es)?\b/,
/\bgranddaughters?\b/,
/\bgrandmas?\b/,
/\bgrandmothers?\b/,
/\bhers?\b/,
/\bheroines?\b/,
/\bherself\b/,
/\bladies\b/,
/\blady\b/,
/\bmoms?\b/,
/\bmothers?\b/,
/\bmrs\b/,
/\bms\b/,
/\bnieces?\b/,
/\bpriestess(es)?\b/,
/\bprincess(es)?\b/,
/\bqueens?\b/,
/\bshe\b/,
/\bsisters?\b/,
/\bspokeswoman\b/,
/\bwaitress(es)?\b/,
/\bwidows?\b/,
/\bwife\b/,
/\bwives\b/,
/\bwoman\b/,
/\bwomen\b/,
]

MALE_WORDS = [
/\bactors?\b/,
/\bboys?\b/,
/\bboyfriends?\b/,
/\bbrothers?\b/,
/\bchairman\b/,
/\bchairmen\b/,
/\bdads?\b/,
/\bdudes?\b/,
/\bfathers?\b/,
/\bfiances?\b/,
/\bgentleman\b/,
/\bgentlemen\b/,
/\bgrandfathers?\b/,
/\bgrandpas?\b/,
/\bgrandsons?\b/,
/\bgrooms?\b/,
/\bguys?\b/,
/\bhe\b/,
/\bhim\b/,
/\bhimself\b/,
/\bhis\b/,
/\bhusbands?\b/,
/\bkings?\b/,
/\bmales?\b/,
/\bman\b/,
/\bmen\b/,
/\bmr\b/,
/\bnephews?\b/,
/\bpriests?\b/,
/\bprinces?\b/,
/\bsons?\b/,
/\bspokesman\b/,
/\buncles?\b/,
/\bwaiters?\b/,
/\bwidowers?\b/,
]

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
      "neutral"
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
      return "neutral"
    else percentage
      return gender
    end
  end

end
