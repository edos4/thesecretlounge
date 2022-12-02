class Qr < ApplicationRecord 
  def self.printqr(str,folder_name, member_name, member)
    print_front(str,folder_name, member_name, member)
    #print_back(str,folder_name, member_name, member)
  end
  
  # def self.print_back(str,folder_name, member_name, member)
  #   require 'rqrcode_png'
  #   require 'fileutils'
    
  #   id = str

  #   dir = Rails.root.join('app/public', "uploads/#{folder_name}")
  #   FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
  #   qr_filename = "#{dir.join("#{member.membership_card_number}.png")}"

  #   txt = Magick::Draw.new
      
  #   qr_with_name = "#{dir.join("#{member.membership_card_number}.png")}"
  #   #( Draw draw, width, height, x, y, “text to add”)

  #   file = File.new("#{qr_filename.split('.').first}.png", File::CREAT|File::TRUNC|File::RDWR, 0644)

  #   #img.write(file)

  #   source = Magick::Image.read("tsl_back.png").first

    # #( Draw draw, width, height, x, y, “text to add”)
    # source.annotate(txt, 600,600,290,82, "#{member.name}".force_encoding("UTF-8")){
    #   txt.gravity = Magick::ForgetGravity
    #   txt.pointsize = 25
    #   txt.font = "#{Rails.root}/proximanova.ttf"
    #   txt.fill = '#000000'
    # }

    # source.annotate(txt, 600,600,440,153, "#{member.membership_date}".force_encoding("UTF-8")){
    #   txt.gravity = Magick::ForgetGravity
    #   txt.pointsize = 25
    #   txt.font = "#{Rails.root}/proximanova.ttf"
    #   txt.fill = '#000000'
    # }

    # source.annotate(txt, 600,600,420,223, "#{member.expiry_date}".force_encoding("UTF-8")){
    #   txt.gravity = Magick::ForgetGravity
    #   txt.pointsize = 25
    #   txt.font = "#{Rails.root}/proximanova.ttf"
    #   txt.fill = '#000000'
    # }
    
  #   source.write("#{qr_filename.split('.').first}-back.png")
  #   File.delete(file)
  #   #@qr
  # end

  def self.print_front(str,folder_name, member_name, member)
    require 'rqrcode_png'
    require 'fileutils'

    @raw = RQRCode::QRCode.new( str, :size => 9, :level => :h )
    @qr = @raw.to_img.resize(100, 100).to_data_url
    
    id = str

    dir = Rails.root.join('app/public', "uploads/#{folder_name}")
    FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
    qr_filename = "#{dir.join("#{member.membership_card_number}.png")}"

    File.open(qr_filename, 'wb') {|f| 
      f.write @raw.as_png(
        resize_gte_to: false,
        resize_exactly_to: false,
        fill: 'white',
        color: 'black',
        size: 20,
        border_modules: 4,
        module_px_size: 4,
        file: nil # path to write
      )
    }

    img = Magick::ImageList.new(qr_filename)
    txt = Magick::Draw.new
      
    qr_with_name = "#{dir.join("#{member.membership_card_number}.png")}"
    #( Draw draw, width, height, x, y, “text to add”)

    file = File.new("#{qr_filename.split('.').first}.png", File::CREAT|File::TRUNC|File::RDWR, 0644)

    img.write(file)

    source = Magick::Image.read("tsl_front.png").first
    overlay = Magick::Image.read(qr_with_name).first
    #nf = source.composite!(overlay, 890, 830, Magick::OverCompositeOp)
    # 1275 x 480
    nf = source.composite!(overlay, 5, 340, Magick::OverCompositeOp)

    #( Draw draw, width, height, x, y, “text to add”)
    nf.annotate(txt, 600,1040,270,368, "#{member.name}".force_encoding("UTF-8")){
      txt.gravity = Magick::ForgetGravity
      txt.pointsize = 25
      txt.font = "#{Rails.root}/proximanova.ttf"
      txt.fill = '#FFFFFF'
    }

    #( Draw draw, width, height, x, y, “text to add”)
    nf.annotate(txt, 600,600,270,408, "#{member.membership_card_number}".force_encoding("UTF-8")){
      txt.gravity = Magick::ForgetGravity
      txt.pointsize = 25
      txt.font = "#{Rails.root}/proximanova.ttf"
      txt.fill = '#FFFFFF'
    }

    nf.annotate(txt, 600,600,270,448, "Reg: #{member.membership_date}".force_encoding("UTF-8")){
      txt.gravity = Magick::ForgetGravity
      txt.pointsize = 25
      txt.font = "#{Rails.root}/proximanova.ttf"
      txt.fill = '#FFFFFF'
    }

    nf.annotate(txt, 600,600,270,488, "Exp: #{member.expiry_date}".force_encoding("UTF-8")){
      txt.gravity = Magick::ForgetGravity
      txt.pointsize = 25
      txt.font = "#{Rails.root}/proximanova.ttf"
      txt.fill = '#FFFFFF'
    }
    
    nf.write("#{qr_filename.split('.').first}-front.png")
    File.delete(file)
    @qr
  end
end
