class Loan < ActiveRecord::Base

  include ApplicationHelper

  attr_accessible :annual_gross_income, :monthly_debt, :downpayment_amount, :downpayment_percent, :fico, :state, :email, :full_name

  after_initialize :set_defaults

  def set_defaults
    if new_record?
      self.annual_gross_income = 70000
      self.monthly_debt = 1000
      self.downpayment_amount = 50000
    end
  end

  def calculate_loan_details args
    calc_max_home_amount
    calc_downpayments args
    calc_loan_amount
    calc_monthly_payment
  end

  def display_max_home_amount
    self.max_home_amount.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end

  def display_downpayment_amount
    self.downpayment_amount.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end

  def display_loan_amount
    self.loan_amount.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end

  def display_annual_gross_income
    self.annual_gross_income.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end

  def display_monthly_debt
    self.monthly_debt.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end

  def calc_downpayments args
    self.update_attribute args[:downpayment][:type], sanitized_downpayment_params(args[:downpayment])

    if args[:downpayment][:type] == 'downpayment_amount'
      calc_downpayment_percent
    else
      calc_downpayment_amount
    end
  end

  private

  def calc_max_home_amount
    self.max_home_amount = (0.5 * self.annual_gross_income/12 - self.monthly_debt ) / ((monthly_interest_rate / (1 - (1 + monthly_interest_rate)**(-number_of_months))) + tax_rate + insurance_percent)
  end

  def calc_downpayment_percent
    self.downpayment_percent = self.downpayment_amount.to_f / self.max_home_amount
  end

  def calc_downpayment_amount
    self.downpayment_amount = (self.downpayment_percent * self.max_home_amount).to_i
  end

  def calc_loan_amount
    self.loan_amount = self.max_home_amount - self.downpayment_amount
  end

  def calc_monthly_payment
    self.monthly_payment = self.max_home_amount *  (monthly_interest_rate / (1 - (1 + monthly_interest_rate)** (-number_of_months)))
  end

  def interest_rate
    0.0425
  end

  def insurance_percent
    0.0035
  end

  def tax_rate
    0.0115 / 12
  end

  def number_of_months
    30 * 12
  end

  def monthly_interest_rate
    interest_rate / 12
  end

  def sanitized_downpayment_params args
    if args[:type] == 'downpayment_amount'
      sanitize_integer(args[:value])
    else
      sanitize_float(args[:value])
    end
  end

end