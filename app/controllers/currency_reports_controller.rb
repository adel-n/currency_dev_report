class CurrencyReportsController < ActionController::Base
	include ActionView::Layouts
  include ActionController::Rendering
  append_view_path "#{Rails.root}/app/views"

	def get_currency_reports
		currency = params[:currency]
		@rates = Currency.calculate_rates(currency)
		if params[:type] == "csv"
			generate_csv
		elsif params[:type] == "xls"
			generate_xls
		elsif params[:type] == "json"
			render json: @rates
		elsif params[:type] == "html"
			render "get_currency_reports"
		end
	end

	private

	def generate_csv
		CSV.open("currency_dev_report.csv", "w") do |csv|
			get_headers_and_rows(csv)
		end
	end

	def generate_xls
		CSV.open("currency_dev_report.xls", "wb") do |csv|
			get_headers_and_rows(csv)
		end
	end

	def get_headers_and_rows(csv)
		#csv << ["Date: #{Date.today}"]
		csv << ["2020-09-19"]
		csv << ["Currency: EUR - #{@rates["currency"]}"]
		csv << ["Rate", "Date", "Delta"]
		@rates["data"].each do |d|
			csv << d[1]
		end
	end
end
