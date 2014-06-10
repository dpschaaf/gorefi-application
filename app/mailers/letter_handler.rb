class LetterHandler < ActionMailer::Base
  default from: 'david.p.schaaf@gmail.com',
          return_path: 'david.p.schaaf@gmail.com'

  def pre_approval_letter(loan)
    @loan = loan
    attachments["GoRefi_Pre_Approval_Letter-#{@loan.id}.pdf"] = File.read("public/pdfs/GoRefi_Pre_Approval_Letter-#{@loan.id}.pdf")
    email_with_name = "#{@loan.full_name} <#{@loan.email}>"
    mail(to: email_with_name, subject: "Your Pre-Approval Letter from GoRefi")
  end

end
