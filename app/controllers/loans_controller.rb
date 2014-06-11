class LoansController < ApplicationController
  include ApplicationHelper

  def new
    @loan = Loan.new
    render :new
  end

  def create
    @loan = Loan.new
    update_loan_attributes @loan, params
    @loan.calculate_loan_details
    @loan.save
    redirect_to loan_path @loan
  end

  def update
    @loan = Loan.find params[:id]
    @loan.update_attributes params[:loan]
    @loan.save
    PdfGenerator.pre_approval_letter(@loan)
    LetterHandler.pre_approval_letter(@loan).deliver
    redirect_to root_path
  end

  def show
    @loan = Loan.find params[:id]
  end

  private

  def update_loan_attributes loan, params
    @loan.update_attributes sanitized_loan_params(params[:loan])
    p params
    @loan.update_attribute params[:downpayment][:type], sanitized_downpayment_params(params[:downpayment])
  end

  def sanitized_loan_params args
    args[:annual_gross_income] = sanitize_integer(args[:annual_gross_income])
    args[:monthly_debt] = sanitize_integer(args[:monthly_debt])
    args
  end

  def sanitized_downpayment_params args
    if args[:type] == 'downpayment_amount'
      p sanitize_integer(args[:value])
    else
      p sanitize_float(args[:value])
    end
  end

end