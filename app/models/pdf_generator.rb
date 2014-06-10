class PdfGenerator

  @@pdf_path = "public/pdfs/"

  def self.pre_approval_letter(loan)
    Prawn::Document.generate("#{@@pdf_path}GoRefi_Pre_Approval_Letter-#{loan.id}.pdf") do
      image "public/GoRefi-logo.png"
      move_down 200
      text "The maximum loan you qualify for is #{loan.max_home_amount}."
    end
  end

end