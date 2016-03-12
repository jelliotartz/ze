class MetricsCalculator

  def initialize(keywords)
    @keywords = keywords
  end

  def keywords_average(keywords)
      keywords.map {|keyword| keyword.sentiment_score }.reduce(0, :+) / keywords.count
  end

  def return_averages_by_gender
    grouped_keywords = @keywords.group_by { |keyword| keyword.gender }
    averages = grouped_keywords.map do |group, keywords|
      [group, keywords_average(keywords)]
    end
    averages
  end
end