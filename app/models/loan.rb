class Loan < ActiveRecord::Base

  attr_accessible :annual_gross_income, :monthly_debt, :downpayment_amount, :downpayment_percent, :fico, :state

  def calculate_loan_details
    @interest_rate = 0.0425
    @insurance_percent = 0.0035
    @tax_rate = 0.0115 / 12
    @number_of_months = 30 * 12
    @monthly_interest_rate = @interest_rate / 12
    self.max_home_amount = calc_max_home_amount
    self.max_home_amount
    calc_downpayment_amount
    calc_downpayment_percent
    self.loan_amount = calc_loan_amount
  end

  private

  def calc_max_home_amount
    (0.5 * self.annual_gross_income/12 - self.monthly_debt ) / ((@monthly_interest_rate / (1 - (1 + @monthly_interest_rate)**(-@number_of_months))) + @tax_rate + @insurance_percent)
  end

  def calc_downpayment_amount
    self.downpayment_amount ||= self.downpayment_percent * self.max_home_amount
  end

  def calc_downpayment_percent
    self.downpayment_percent ||= self.downpayment_amount / self.max_home_amount
  end

  def calc_loan_amount
    self.max_home_amount - self.downpayment_amount
  end

end