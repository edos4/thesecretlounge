class ImportsController < ApplicationController
  def members
  end

  def export_qr
    require 'zip'

    @members = Member.all
    @folder_name = SecureRandom.hex

    Member.all.each do |member|
      Qr.printqr("#{member.membership_card_number}", @folder_name, member.name)
    end

    files = Dir.glob("app/public/uploads/#{@folder_name}/*final*.png")
    zip_file = "app/public/uploads/#{@folder_name}/qr_export.zip"

    File.delete(zip_file) if File.exist?(zip_file)

    Zip::File.open(zip_file, Zip::File::CREATE) do |z|
      files.each do |f|
        z.add(f.split("/").last, f)
      end
    end

    send_file zip_file, type: 'application/zip', disposition: 'attachment', filename: "qr_export.zip"
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
        email = spreadsheet.row(i)[1]
        contact_number = spreadsheet.row(i)[2]
        address = spreadsheet.row(i)[3]
        branch = spreadsheet.row(i)[4]
        membership_card_number = spreadsheet.row(i)[5]
        membership_date = Date.parse(spreadsheet.row(i)[6])
        expiry_date = Date.parse(spreadsheet.row(i)[7])
        beauty_bank = spreadsheet.row(i)[8]
        loyalty_points = spreadsheet.row(i)[9]

        member = Member.create(
          name: name, 
          contact_number: contact_number,
          email: email,
          address: address,
          branch: Branch.find_by(name: branch),
          membership_card_number: membership_card_number,
          membership_date: membership_date,
          expiry_date: expiry_date,
          beauty_bank: beauty_bank,
          loyalty_points: loyalty_points
        )

      end
      flash[:notice] = "Records Imported"
      redirect_to '/members' 
    rescue Exception => e
      flash[:alert] = "Issues with Member List. Error: #{e}. #{current_name}"
      redirect_to '/members' 
    end
  end
end
