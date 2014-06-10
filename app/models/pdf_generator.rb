class PdfGenerator

  @@pdf_path = "public/pdfs/"
  @@title = "GoRefi_Pre_Approval_Letter-"

  def self.letter_name
    "#{@@pdf_path}#{@@title}"
  end

  def self.pre_approval_letter(loan)
    Prawn::Document.generate("#{PdfGenerator.letter_name}#{loan.id}.pdf") do
      image "public/GoRefi-logo.png"
      move_down 200
      text "The maximum loan you qualify for is #{loan.max_home_amount}."
    end
  end

end