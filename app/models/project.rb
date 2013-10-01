class Project
  include Mongoid::Document

  ## Fields
  field :name, :type => String
  field :bundleID, :type => String

  ## Validators
  validates_uniqueness_of :name
  validates_presence_of :name
  validates_presence_of :organization
  validates_presence_of :bundleID

  ## Associations
  embedded_in :organization
  has_many :customers
  has_many :users
  embeds_many :ipa_apps
  embeds_many :apk_apps

end
