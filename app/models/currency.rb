class Currency < ApplicationRecord
	validates :code, presence: true, length: {is: 3}, format: {with: /[A-Z]/}
	validates_presence_of :rate, :date

	def self.calculate_rates(currency)
		date = "2020-09-19".to_date
		rate_today = Currency.find_by(code: currency, date: date).rate
		rate_yesterday = Currency.find_by(code: currency, date: date - 1.days).rate
		rate_week_ago = Currency.find_by(code: currency, date: date - 1.weeks).rate
		rate_month_ago = Currency.find_by(code: currency, date: date - 1.months).rate
		rate_year_ago = Currency.find_by(code: currency, date: date - 1.years).rate
		rate_hash = {}
		rate_hash["currency"] = currency
		rate_hash["data"] = {}
		rate_hash["data"]["today"] = [rate_today, date.to_time, 0]
		rate_hash["data"]["yesterday"] = [rate_yesterday, (date - 1.days).to_time, rate_today - rate_yesterday]
		rate_hash["data"]["week_ago"] = [rate_week_ago, (date - 1.weeks).to_time, rate_today - rate_week_ago]
		rate_hash["data"]["month_ago"] = [rate_month_ago, (date - 1.months).to_time, rate_today - rate_month_ago]
		rate_hash["data"]["year_ago"] = [rate_year_ago, (date - 1.years).to_time, rate_today - rate_year_ago]
		rate_hash
	end
end
