class Ipabuild
  include Mongoid::Document
  require 'ipa'

  ## Fields
  field :packagename, :type => String
  field :bundleID, :type => String
  field :version, :type => String
  field :icon_uid, :type => String
  field :package_uid, :type => String
  field :taken, :type => Time

  ## Accessors
  image_accessor :icon do
    storage_path{ "builds/#{self._parent.name}/icon.#{self.version}" }
  end
  file_accessor :package do
    storage_path{ "builds/#{self._parent.name}/version.#{self.version}" }
  end

  ## Validators
  validates_presence_of :package
  validates_property :format, :of => :package, :in => [:ipa]
  validates_uniqueness_of :version

  ## Associations
  embedded_in :ipaapp

  ## Methods
  def ipa_process
    @ipa = IPA::IPAFile.new(self.package.file);
    self.bundleID = @ipa.identifier
    begin
      self.icon = @ipa.artwork
    rescue Errno::ENOENT
      self.icon_url = "http://placehold.it/50x50"
    end
    self.version = @ipa.version_string
    self.packagename = @ipa.display_name
    self.taken = Time.now
  end

end
