class ImportsController < ApplicationController
  def members
  end

  def upload_members
    begin
      current_name = ""
      file = params[:imports][:member_list]
      file_ext = File.extname(file.original_filename)
      raise "Unknown file type: #{file.original_filename}" unless [".xls", ".xlsx"].include?(file_ext)
      spreadsheet = (file_ext == ".xls") ? Roo::Excel.new(file.path) : Roo::Excelx.new(file.path)
      header = spreadsheet.row(1)

      # 1 is the header row, so we skip it
      (2..spreadsheet.last_row).each do |i|
        #puts "#{spreadsheet.row(i)[0]} #{spreadsheet.row(i)[1]}"
        name = spreadsheet.row(i)[0]
        mobile_number = spreadsheet.row(i)[1]

        member = Citizen.create(name: name, mobile_number: mobile_number)

        tag_array = spreadsheet.row(i)[2].split(',')
        tag_array.each do |tag|
          member.tags << Tag.find_by(name: tag)
        end
      end
      flash[:notice] = "Records Imported"
      redirect_to '/citizens' 
    rescue Exception => e
      flash[:alert] = "Issues with Member List. Error: #{e}. #{current_name}"
      redirect_to '/imports/members' 
    end
  end
end
