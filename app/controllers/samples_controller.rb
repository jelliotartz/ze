class SamplesController < ApplicationController
	require 'pry'

	def index
	end

	def create
		@sample = Sample.new(sample_params)
		text = @sample.content
  	@response = HTTParty.post("http://access.alchemyapi.com/calls/text/TextGetRankedNamedEntities",
    :query => { :apikey => ENV['SECRET_ALCHEMY'],
               :text => text,
               :outputMode => 'json',
               :sentiment => 1
             },
    :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' } )

    @parsed_response = JSON.parse(@response.body)

    @entity_info = []

    def entity_stuff(parsed_response)
      @entities = parsed_response['entities']
      @entities.each do |entity|
        entity_name = entity['text']
        entity_sentiment = entity['sentiment']['type']
        entity_score = entity['sentiment']['score']
        entity_data = [entity_name, entity_sentiment, entity_score]
        @entity_info << entity_data
        p entity_data
      end
    end

    entity_stuff(@parsed_response)
    p @entity_info

    # @output = @parsed_response['entities'][0]['sentiment']
    # @clinton_name = @parsed_response['entities'][0]['text']
    # @clinton_sentiment = @parsed_response['entities'][0]['sentiment']['type']
    # @clinton_score = @parsed_response['entities'][0]['sentiment']['score']

    render 'new'

    #
	end

	def new
		@sample = Sample.new
	end

	def show
	end

	def destroy
	end

	private
	def sample_params
		params.require(:sample).permit(:content)
	end
end
