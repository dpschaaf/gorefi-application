class PdfGenerator

  @@pdf_path = "public/pdfs/"
  @@title = "GoRefi_Pre_Approval_Letter-"

  def self.letter_path
    "#{@@pdf_path}#{@@title}"
  end

  def self.letter_title
    "#{@@title}"
  end

  def self.pre_approval_letter(loan)
    Prawn::Document.generate("#{PdfGenerator.letter_name}#{loan.id}.pdf") do
      image "public/GoRefi-logo.png"
      move_down 100
      text "The maximum loan you qualify for is $#{number_with_delimiter(loan.loan_amount, :delimiter => ',')}."
      move_down 100
      text "Thank you for choosing GoRefi."
    end
  end

end