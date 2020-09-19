class Currency < ApplicationRecord
	validates :code, presence: true, length: {is: 3}, format: {with: /[A-Z]/}
	validates_presence_of :rate, :date

	def self.calculate_rates(currency)
		rate_today = Currency.find_by(code: currency, date: Date.today).rate
		rate_yesterday = Currency.find_by(code: currency, date: Date.today - 1.days).rate
		rate_week_ago = Currency.find_by(code: currency, date: Date.today - 1.weeks).rate
		rate_month_ago = Currency.find_by(code: currency, date: Date.today - 1.months).rate
		rate_year_ago = Currency.find_by(code: currency, date: Date.today - 1.years).rate
		rate_hash = {}
		rate_hash["data"] = {}
		rate_hash["data"]["today"] = [rate_today, (Date.today).to_time, 0]
		rate_hash["data"]["yesterday"] = [rate_yesterday, (Date.today - 1.days).to_time, rate_today - rate_yesterday]
		rate_hash["data"]["week_ago"] = [rate_week_ago, (Date.today - 1.weeks).to_time, rate_today - rate_week_ago]
		rate_hash["data"]["month_ago"] = [rate_month_ago, (Date.today - 1.months).to_time, rate_today - rate_month_ago]
		rate_hash["data"]["year_ago"] = [rate_year_ago, (Date.today - 1.years).to_time, rate_today - rate_year_ago]
		rate_hash
	end
end
