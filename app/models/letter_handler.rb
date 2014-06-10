class LetterHandler < ActionMailer::Base
  default from: 'david.p.schaaf@gmail.com',
          return_path: 'david.p.schaaf@gmail.com',
          subject: "Your Pre-Approval Letter",
          body: "Please find attached your mortgage pre-approval letter from GoRefi."

  def self.send_pre_approval_letter(loan)
    attachments["GoRefi_Pre_Approval_Letter-#{loan.id}.pdf"] = File.read("public/pdfs/GoRefi_Pre_Approval_Letter-#{loan.id}.pdf")
    mail(to: loan.email)
    deliver
  end

end