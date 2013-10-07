class Ipabuild
  include Mongoid::Document
  require 'ipa_reader'

  ## Fields
  field :packagename, :type => String
  field :version, :type => String
  field :icon_uid, :type => String
  field :package_uid, :type => String
  field :taken, :type => Time

  ## Accessors
  image_accessor :icon do
    storage_path{ "#{self._parent._parent.name}/ipaapps/#{self._parent.name}/builds/icon.#{self.version}" }
  end
  file_accessor :package do
    storage_path{ "#{self._parent._parent.name}/ipaapps/#{self._parent.name}/builds/#{self.version}/#{self.version}" }
  end

  ## Validators
  validates_presence_of :package
  validates_property :format, :of => :package, :in => [:ipa]
  validates_uniqueness_of :version
  validate :validate_bundleID

  ## Associations
  embedded_in :ipaapp

  ## Methods
  def ipa_process
    @ipa = IpaReader::IpaFile.new(self.package.file.path.to_str);
    self.packagename = @ipa.name
    begin
      self.icon = @ipa.icon_file
    rescue Errno::ENOENT
      self.icon_url = "http://placehold.it/50x50"
    end
    self.version = @ipa.version
    self.packagename = @ipa.display_name
    self.taken = Time.now
  end

  def validate_bundleID
    if self._parent.bundleID == IpaReader::IpaFile.new(self.package.file).bundle_identifier
      return true
    else
      self.errors.full_messages << "BundleID Error"
      return false
    end
  end

end
