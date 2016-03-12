class SamplesController < ApplicationController
	require 'pry'

	def index
	end

	def create

		@sample = Sample.new(sample_params)

    caller = AlchemyCaller.new(@sample)
    caller.call_API
    caller.convert_to_keyword_objects

    @keywords = @sample.keywords

    calculator = MetricsCalculator.new(@sample.keywords)
    @averages = calculator.return_averages_by_gender

    @sample.user_id = session[:user_id]
    @sample.save

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
