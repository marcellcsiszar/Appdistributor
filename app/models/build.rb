class Build
  include Mongoid::Document
  field :packagename, :type => String
  field :bundleID, :type => String
  field :version,	:type => String
  field :platform, :type => String
  image_accessor :icon
  field :icon_uid, :type => String
  embedded_in :project
  file_accessor :package
  field :package_uid, :type => String
  field :taken, :type => Time
  validates_presence_of :package
  validates_property :format, :of => :package, :in => [:apk, :ipa]
  #validates_uniqueness_of :version
end
