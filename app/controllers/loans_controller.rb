class LoansController < ApplicationController
  include ApplicationHelper

  def new
    @loan = Loan.new
    render :new
  end

  def create
    @loan = Loan.new
    update_loan_attributes @loan, params
    redirect_to edit_loan_path @loan
  end

  def update
    @loan = Loan.find params[:id]
    update_loan_attributes @loan, params
    PdfGenerator.pre_approval_letter(@loan)
    LetterHandler.pre_approval_letter(@loan).deliver
    redirect_to root_path
  end

  def calculator
    @loan = Loan.find params[:id]
    update_loan_attributes @loan, params
    render partial: 'calculator', locals: {loan: @loan}
  end

  def edit
    @loan = Loan.find params[:id]
  end

  private

  def update_loan_attributes loan, params
    loan.update_attributes sanitized_loan_params(params[:loan])
    loan.calculate_loan_details params
    loan.save
  end

  def sanitized_loan_params args
    args[:annual_gross_income] = sanitize_integer(args[:annual_gross_income])
    args[:monthly_debt] = sanitize_integer(args[:monthly_debt])
    args
  end

end