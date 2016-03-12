class AlchemyCaller
  def initialize(sample)
    @sample = sample
  end

  def call_API
    response = HTTParty.post("http://access.alchemyapi.com/calls/text/TextGetRankedNamedEntities",
    :query => { :apikey => ENV['SECRET_ALCHEMY'],
               :text => @sample.content,
               :outputMode => 'json',
               :sentiment => 1
             },
    :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' } )
    JSON.parse(response.body)
  end
end