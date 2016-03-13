module SamplesHelper
  def markup_keywords(sample)
    # content = sample.content

    # keyword_replacements = {}
    # sample.keywords.each do |keyword|
    #   keyword_replacements[keyword.text] = wrap_keyword(sample, keyword)
    # end

    # keyword_regex = sample.keywords.map{ |keyword|
    #   "\b(" + keyword.text + ")\b"
    # }.join("|")
    # binding.pry
    # content.gsub(/#{keyword_regex}/, keyword_replacements)
    sample.content
  end

  def wrap_keyword(sample, keyword)
    "<span class='keyword #{keyword.gender} #{keyword.sentiment_type}' data-sentiment-score=#{keyword.sentiment_score} >#{keyword.text}</span>"
  end
end