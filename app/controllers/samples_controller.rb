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

    caller = AlchemyCaller.new(@sample)
    parsed_response = caller.call_API

    @gendered_keywords = GenderDetector.transform_all(parsed_response['keywords'])

    calculator = MetricsCalculator.new(@gendered_keywords)
    @averages = calculator.return_averages_by_gender

    render 'new'

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
