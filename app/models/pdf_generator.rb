class PdfGenerator

  @@pdf_path = "public/pdfs/"

  def pre_approval_letter(loan)
    Prawn::Document.generate("#{@@pdf_path}GoRefi_Pre_Approval_Letter-#{loan.id}") do
      image "#{Prawn::DATADIR}/public/GoRefi-logo.png"

      text "text The maximum loan you qualify for is #{loan.max_home_amount}"
    end
  end

end