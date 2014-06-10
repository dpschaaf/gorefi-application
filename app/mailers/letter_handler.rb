class LetterHandler < ActionMailer::Base

  default from: 'david.p.schaaf@gmail.com',
          subject: "Your Pre-Approval Letter from GoRefi"

  def pre_approval_letter(loan)
    @loan = loan
    attachments["GoRefi_Pre_Approval_Letter-#{@loan.id}.pdf"] = File.read("#{PdfGenerator.letter_name}#{@loan.id}.pdf")
    mail(to: @loan.email)
  end

end
