class Apkbuild
  include Mongoid::Document
  require 'ruby_apk'

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
  validates_property :format, :of => :package, :in => [:apk]
  validates_uniqueness_of :version

  ## Associations
  embedded_in :apkapp

  ## Methods
  def apk_process
    @apk = Android::Apk.new(self.package.file)
    self.bundleID = @apk.manifest.package_name
    self.icon = @apk.icon.values.last
    self.version = @apk.manifest.version_code
    self.packagename = @apk.resource.find(@apk.manifest.label)
    self.taken = Time.now
  end

end
