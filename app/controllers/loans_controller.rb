class LoansController < ApplicationController

  def new
    @loan = Loan.new
    render :new
  end

  def create
    @loan = Loan.new
    @loan.update_attributes params[:loan]

    if params[:downpayment].to_f < 1
      params[:downpayment].to_f
      @loan.update_attribute :downpayment_percent, params[:downpayment].to_f
    else
      params[:downpayment].to_i
      @loan.update_attribute :downpayment_amount, params[:downpayment].to_i
    end

    @loan.calculate_loan_details
    @loan.save

    redirect_to loan_path @loan
  end

  def update
    @loan = Loan.find params[:id]
    @loan.update_attributes params[:loan]
    @loan.save
    PdfGenerator.pre_approval_letter(@loan)
    LetterHandler.send_pre_approval_letter(@loan)
    redirect_to root_path
  end



  def show
    @loan = Loan.find params[:id]
  end

end