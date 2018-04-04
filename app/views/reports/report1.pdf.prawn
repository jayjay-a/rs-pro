prawn_document do |pdf|
  pdf.text 'Terminated Subcontractors:'
  pdf.move_down 10


   data = [['Subcontractor Name', 'Company']]
   data += @term_subs.collect{|p| [p['subcontractor_name'], p['company']]}
   pdf.table(data, :header => true)

end
