class Qr < ApplicationRecord 
  def self.printqr(str,folder_name, member_name, member)
    require 'rqrcode_png'
    require 'fileutils'
    # replace first_name and last_name
    # participant becomes member

    @raw = RQRCode::QRCode.new( str, :size => 9, :level => :h )
    @qr = @raw.to_img.resize(100, 100).to_data_url
    
    id = str

    dir = Rails.root.join('app/public', "uploads/#{folder_name}")
    FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
    qr_filename = "#{dir.join("#{id}_#{member.membership_card_number}.png")}"

    File.open(qr_filename, 'wb') {|f| 
      f.write @raw.as_png(
        resize_gte_to: false,
        resize_exactly_to: false,
        fill: 'white',
        color: 'black',
        size: 100,
        border_modules: 4,
        module_px_size: 6,
        file: nil # path to write
      )
    }

    img = Magick::ImageList.new(qr_filename)
    txt = Magick::Draw.new
      
    qr_with_name = "#{dir.join("#{id}_#{member.membership_card_number}.png")}"
    #( Draw draw, width, height, x, y, “text to add”)

    file = File.new("#{qr_filename.split('.').first}.png", File::CREAT|File::TRUNC|File::RDWR, 0644)

    img.write(file)

    source = Magick::Image.read("tsl_front.png").first
    overlay = Magick::Image.read(qr_with_name).first
    #nf = source.composite!(overlay, 890, 830, Magick::OverCompositeOp)
    # 1275 x 480
    nf = source.composite!(overlay, 0, 0, Magick::OverCompositeOp)

    nf.annotate(txt, 600,1040,400,240, "#{member.membership_card_number}".force_encoding("UTF-8")){
      txt.gravity = Magick::ForgetGravity
      txt.pointsize = (member.membership_card_number.length) >= 13 ? 75 : 140 
      txt.font = "#{Rails.root}/proximanova.ttf"
      txt.fill = '#000000'
    }
    
    nf.write("#{qr_filename.split('.').first}-final.png")
    File.delete(file)
    @qr
  end
end