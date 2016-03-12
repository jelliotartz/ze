class SamplesController < ApplicationController
	require 'pry'

	def index
	end

	def create

=begin

  user puts in text or URL, etc.
  call to API

  run responses through gender detection
  run responses through analysis calculator

  render view

=end



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
    @gendered_entities = GenderDetector.transform_all(@parsed_response['entities'])


    def entities_average(entities)
      entities.map {|entity| entity['sentiment']['score'].to_f}.reduce(0, :+) / entities.count
    end

    grouped_entities = @gendered_entities.group_by { |entity| entity['gender'] }

    @averages = grouped_entities.map do |group, entities|
      [group, entities_average(entities)]
    end

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
