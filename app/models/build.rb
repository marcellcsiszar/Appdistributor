class Build
  include Mongoid::Document
  require 'ruby_apk'
  require 'ipa'

  ## Fields
  field :packagename, :type => String
  field :bundleID, :type => String
  field :version, :type => String
  field :platform, :type => String
  field :icon_uid, :type => String
  field :package_uid, :type => String
  field :taken, :type => Time

  ## Accessors
  image_accessor :icon
  file_accessor :package

  ## Validators
  validates_presence_of :package
  validates_property :format, :of => :package, :in => [:apk, :ipa]
  validates_uniqueness_of :version

  ## Associations
  embedded_in :project

  ## Methods
  def fetch_app_infos
    if self.package.mime_type == "application/vnd.android.package-archive"
      self.platform = "Android"
      apk_process()
    elsif self.package.mime_type == "application/octet-stream"
      self.platform = "iOS"
      ipa_process()
    else
      self.platform = "@build.package.mime_type"
      self.taken = File.ctime(self.package.file)
    end
  end

  private
  def apk_process
    @apk = Android::Apk.new(self.package.file)
    self.bundleID = @apk.manifest.package_name
    self.icon = @apk.icon.values.last
    self.version = @apk.manifest.version_code
    self.packagename = @apk.resource.find(@apk.manifest.label)
    self.taken = @apk.time
  end

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
    self.taken = File.ctime(self.package.file)
  end

end
