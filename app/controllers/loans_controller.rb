class LoansController < ApplicationController

  def new
    @loan = Loan.new
    render :new
  end

  def create
    @loan = Loan.new
    @loan.update_attributes state: params[:state], fico: params[:fico].to_i, annual_gross_income: params[:annual_gross_income].to_i, monthly_debt: params[:monthly_debt].to_i

    if params[:downpayment].to_f < 1
      params[:downpayment].to_f
      @loan.update_attribute :downpayment_percent, params[:downpayment].to_f
    else
      params[:downpayment].to_i
      @loan.update_attribute :downpayment_amount, params[:downpayment].to_i
    end

    @loan.calculate_loan_details
    @loan.save
    p '*******'
    p @loan
    redirect_to loan_path @loan
  end

  def show
    @loan = Loan.find params[:id]
  end

end