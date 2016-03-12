module SamplesHelper
  def markup_keywords(sample)
    content = sample.content
    sample.keywords.each do |keyword|
      content = content.gsub(keyword.text, "<span class='keyword #{keyword.gender} #{keyword.sentiment_type}' data-sentiment-score=#{keyword.sentiment_score} >#{keyword.text}</span>")
    end
    content
  end
end