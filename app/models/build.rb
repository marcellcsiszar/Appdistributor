class Build
  include Mongoid::Document

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

end
