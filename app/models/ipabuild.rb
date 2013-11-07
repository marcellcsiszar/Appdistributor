class Ipabuild
  include Mongoid::Document
  require 'ipa'

  ## Fields
  field :packagename, :type => String
  field :version, :type => String
  field :icon_uid, :type => String
  field :plist_uid, :type => String
  field :package_uid, :type => String
  field :taken, :type => Time
  field :buildnum, :type => String

  ## Accessors
  image_accessor :icon do
    storage_path{ "#{self._parent._parent.name}/ipaapps/#{self._parent.name}/builds/#{self.version}/icon.#{self.version}" }
  end
  file_accessor :package do
    storage_path{ "#{self._parent._parent.name}/ipaapps/#{self._parent.name}/builds/#{self.version}/#{self.version}" }
  end
  file_accessor :plist do
    storage_path{ "#{self._parent._parent.name}/ipaapps/#{self._parent.name}/builds/#{self.version}/#{self.version}.plist" }
  end

  ## Validators
  validates_presence_of :package
  validate do
    if self.package.mime_type != "application/octet-stream" || self._parent.bundleID != IPA::IPAFile.new(self.package.file).identifier
      then
        errors.add(:base)
    end
  end

  ## Associations
  embedded_in :ipaapp
  has_many :notifications

  ## Methods
  def ipa_process
    if self.package.mime_type == "application/octet-stream"
      @ipa = IPA::IPAFile.new(self.package.file);
      self.packagename = @ipa.name
      begin
      self.icon = normalize_png(@ipa.icon)
      rescue
      self.icon_url = "http://placehold.it/50x50"
      end
      self.buildnum = @ipa.info["CFBundleVersion"]
      self.version = if @ipa.info["CFBundleShortVersionString"].nil? then self.buildnum else @ipa.info["CFBundleShortVersionString"] end
      self.packagename = @ipa.name
      self.taken = Time.now
    end
  end

  def generate_plist(url)
    @doctype = '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>items</key>
  <array>
    <dict>
      <key>assets</key>
      <array>
        <dict>
          <key>kind</key>
          <string>software-package</string>
          <key>url</key>
          <string>'
    @bi_header = '</string>
        </dict></array>
      <key>metadata</key>
      <dict><key>bundle-identifier</key>
        <string>'
    @bv_header = '</string>
        <key>bundle-version</key>
        <string>'
    @title = '</string>
        <key>kind</key>
        <string>software</string>
        <key>title</key>
        <string>'
    @footer = '</string>
      </dict>
    </dict>
  </array>
</dict>
</plist>'
    self.plist = @doctype+url+@bi_header+self._parent.bundleID+@bv_header+self.version+@title+self._parent.name+@footer
  end

  def normalize_png(oldPNG)
      newPNG = oldPNG[0...8]
      chunkPos = newPNG.length
      # For each chunk in PNG
      while chunkPos < oldPNG.length
        # Reading chunk
        chunkLength = oldPNG[chunkPos...chunkPos+4]
        chunkLength = chunkLength.unpack("N")[0]
        chunkType = oldPNG[chunkPos+4...chunkPos+8]
        chunkData = oldPNG[chunkPos+8...chunkPos+8+chunkLength]
        chunkCRC = oldPNG[chunkPos+chunkLength+8...chunkPos+chunkLength+12]
        chunkCRC = chunkCRC.unpack("N")[0]
        chunkPos += chunkLength + 12
        # Header chunk parsing
        if chunkType == "IHDR"
          width = chunkData[0...4].unpack("N")[0]
          height = chunkData[4...8].unpack("N")[0]
        end
        # Image chunk parsing
        if chunkType == "IDAT"
          # Uncompress the chunk
          inf = Zlib::Inflate.new(-Zlib::MAX_WBITS)
          chunkData = inf.inflate(chunkData)
          inf.finish
          inf.close
          # Swapping red & blue bytes on every pixel
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
          # Compressing the chunk
          chunkData = newdata
          chunkData = Zlib::Deflate.deflate( chunkData )
          chunkLength = chunkData.length
          chunkCRC = Zlib.crc32(chunkType)
          chunkCRC = Zlib.crc32(chunkData, chunkCRC)
          chunkCRC = (chunkCRC + 0x100000000) % 0x100000000
        end
        # Removing the CgBI part
        if chunkType != "CgBI"
          newPNG += [chunkLength].pack("N")
          newPNG += chunkType
          if chunkLength > 0
            newPNG += chunkData
          end
          newPNG += [chunkCRC].pack("N")
        end
        # Stopping PNG file parse
        if chunkType == "IEND"
          break
        end
      end
    return newPNG
  end
end
