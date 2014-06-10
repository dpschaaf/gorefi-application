class LoansController < ApplicationController

  def new
    @loan = Loan.new
    render :new
  end

  def create
    @loan = Loan.new
    @loan.update_attributes params[:loan]
    @loan.update_attribute params[:downpayment][:type], params[:downpayment][:value].to_f
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

end