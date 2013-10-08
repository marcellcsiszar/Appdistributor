class Ipabuild
  include Mongoid::Document
  require 'ipa'

  ## Fields
  field :packagename, :type => String
  field :version, :type => String
  field :icon_uid, :type => String
  field :package_uid, :type => String
  field :taken, :type => Time

  ## Accessors
  image_accessor :icon do
    storage_path{ "#{self._parent._parent.name}/ipaapps/#{self._parent.name}/builds/#{self.version}/icon.#{self.version}" }
  end
  file_accessor :package do
    storage_path{ "#{self._parent._parent.name}/ipaapps/#{self._parent.name}/builds/#{self.version}/#{self.version}" }
  end

  ## Validators
  validates_presence_of :package
  validates_property :format, :of => :package, :in => [:ipa]
  validate :valid_bundleID

  ## Associations
  embedded_in :ipaapp

  ## Methods
  def ipa_process
    @ipa = IPA::IPAFile.new(self.package.file);
    self.packagename = @ipa.name
    begin
    self.icon = normalize_png(@ipa.icon)
    rescue
    self.icon_url = "http://placehold.it/50x50"
    end
    self.version = @ipa.version
    self.packagename = @ipa.name
    self.taken = Time.now
  end

  def valid_bundleID
    if self._parent.bundleID == IPA::IPAFile.new(self.package.file).identifier
      return true
    else
      return false
    end
  end

  def normalize_png(oldPNG)
      newPNG = oldPNG[0...8]
      chunkPos = newPNG.length
      # For each chunk in the PNG file
      while chunkPos < oldPNG.length
        # Reading chunk
        chunkLength = oldPNG[chunkPos...chunkPos+4]
        chunkLength = chunkLength.unpack("N")[0]
        chunkType = oldPNG[chunkPos+4...chunkPos+8]
        chunkData = oldPNG[chunkPos+8...chunkPos+8+chunkLength]
        chunkCRC = oldPNG[chunkPos+chunkLength+8...chunkPos+chunkLength+12]
        chunkCRC = chunkCRC.unpack("N")[0]
        chunkPos += chunkLength + 12

        # Parsing the header chunk
        if chunkType == "IHDR"
          width = chunkData[0...4].unpack("N")[0]
          height = chunkData[4...8].unpack("N")[0]
        end
        # Parsing the image chunk
        if chunkType == "IDAT"
          # Uncompressing the image chunk
          inf = Zlib::Inflate.new(-Zlib::MAX_WBITS)
          chunkData = inf.inflate(chunkData)
          inf.finish
          inf.close
          # Swapping red & blue bytes for each pixel
          newdata = ""
          height.times do
            i = newdata.length
            newdata += chunkData[i..i].to_s
            width.times do
              i = newdata.length
              newdata += chunkData[i+2..i+2].to_s
              newdata += chunkData[i+1..i+1].to_s
              newdata += chunkData[i+0..i+0].to_s
              newdata += chunkData[i+3..i+3].to_s
            end
          end

          # Compressing the image chunk
          chunkData = newdata
          chunkData = Zlib::Deflate.deflate( chunkData )
          chunkLength = chunkData.length
          chunkCRC = Zlib.crc32(chunkType)
          chunkCRC = Zlib.crc32(chunkData, chunkCRC)
          chunkCRC = (chunkCRC + 0x100000000) % 0x100000000
        end
        # Removing CgBI chunk
        if chunkType != "CgBI"
          newPNG += [chunkLength].pack("N")
          newPNG += chunkType
          if chunkLength > 0
            newPNG += chunkData
          end
          newPNG += [chunkCRC].pack("N")
        end
        # Stopping the PNG file parsing
        if chunkType == "IEND"
          break
        end
      end
    return newPNG
  end
end
