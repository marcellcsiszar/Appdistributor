class Apkbuild
  include Mongoid::Document
  require 'ruby_apk'

  ## Fields
  field :packagename, :type => String
  field :version, :type => String
  field :icon_uid, :type => String
  field :package_uid, :type => String
  field :taken, :type => Time
  field :buildnum, :type => String

  ## Accessors
  image_accessor :icon do
    storage_path{ "#{self._parent._parent.name}/apkapps/#{self._parent.name}/builds/#{self.version}/icon.#{self.version}" }
  end
  file_accessor :package do
    storage_path{ "#{self._parent._parent.name}/apkapps/#{self._parent.name}/builds/#{self.version}/#{self.version}" }
  end

  ## Validators
  validates_presence_of :package
  validates_property :format, :of => :package, :in => [:apk]
  validate do
    if self._parent.bundleID != Android::Apk.new(self.package.file).manifest.package_name
      then
        errors.add(:base)
    end
  end

  ## Associations
  embedded_in :apkapp
  has_many :notifications

  ## Methods
  def apk_process
    @apk = Android::Apk.new(self.package.file)
    self.buildnum = @apk.manifest.version_code
    begin
    self.icon = @apk.icon.values.last
    rescue
    self.icon_url = "http://placehold.it/50x50"
    end
    self.version = @apk.manifest.version_name
    if /^@(\w+\/\w+)|(0x[0-9a-fA-F]{8})$/ =~ @apk.manifest.label
    self.packagename = @apk.resource.find(@apk.manifest.label)
    else
    self.packagename = @apk.manifest.label
    end
    self.taken = Time.now
  end

end
