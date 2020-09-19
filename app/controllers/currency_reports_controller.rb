class CurrencyReportsController < ApplicationController

	def get_currency_reports
		currency = params[:currency]
		@rates = Currency.calculate_rates(currency)
		if params[:type] == "csv"
			generate_csv
		elsif params[:type] == "xls"

		elsif params[:type] == "json"
			render json: @rates
		elsif params[:type] == "html"

		end
	end


	def generate_csv
		CSV.generate do |csv|
			csv << ["Date": Date.today]
			csv << ["Rate", "Date", "Delta"]
			@rates["data"].each do |d|
				byebug
				csv << d[1]
			end
		end
	end
end
