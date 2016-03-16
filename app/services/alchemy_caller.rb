class AlchemyCaller

  attr_accessor :response

  def initialize(sample)
    @sample = sample
    @response = nil
  end

  def call_API
    max_length = 3000
    # if @sample.content is small enough
    p @sample.content.length
    p @sample.content
    p @sample.content.length
    if @sample.content.length < max_length
      p "in the small version"
      response = HTTParty.post("http://access.alchemyapi.com/calls/text/TextGetRankedKeywords",
        :query => { :apikey => ENV["SECRET_ALCHEMY"],
                 :text => @sample.content,
                 :outputMode => 'json',
                 :sentiment => 1
               },
        :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' } )
    else
      p "in the big version"
      response = HTTParty.post("http://access.alchemyapi.com/calls/text/TextGetRankedKeywords",
        :query => { :apikey => ENV["SECRET_ALCHEMY"],
                 :text => @sample.content[0..4000],
                 :outputMode => 'json',
                 :sentiment => 1
               },
        :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' } )
    end
    @response = JSON.parse(response.body)
  end


  def convert_to_keyword_objects
    if @response && @response['keywords']
      keywords = @response['keywords']
      keywords.each do |keyword|
        @sample.keywords << Keyword.new({
                                          text: keyword["text"],
                                          sentiment_type: keyword["sentiment"]["type"],
                                          sentiment_score: keyword["sentiment"]["score"],
                                          gender: GenderDetector.detect(keyword["text"]),
                                        })
      end
    end
  end
end
