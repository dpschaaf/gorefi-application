class LetterHandler < ActionMailer::Base

  default from: 'gorefipreapproval@gmail.com',
          subject: "Your Pre-Approval Letter from GoRefi"

  def pre_approval_letter(loan)
    @loan = loan
    attachments["#{PdfGenerator.letter_title}#{@loan.id}.pdf"] = File.read("#{PdfGenerator.letter_path}#{@loan.id}.pdf")
    mail(to: @loan.email)
  end

end
