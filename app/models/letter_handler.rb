class LetterHandler < ActionMailer::Base
   default from: 'no-reply@example.com',
          return_path: 'system@example.com'

  def send_pre_approval_letter(loan)
    @account = recipient
    mail(to: recipient.email_address_with_name)
    attachments["GoRefi_Pre_Approval_Letter-#{loan.id}"] = File.read("app/assets/pdfs/126539_statistics.pdf")
mail(:to => email, :subject => subject, :body => message,  :content_type => 'application/pdf')
  end

end