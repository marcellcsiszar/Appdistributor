class Project
  include Mongoid::Document

  ## Fields
  field :name, :type => String
  field :bundleID, :type => String

  ## Validators
  validates_uniqueness_of :name
  validates_uniqueness_of :bundleID

  validates_presence_of :name
  validates_presence_of :bundleID

  ## Associations
  embedded_in :organization
  has_and_belongs_to_many :customers
  has_and_belongs_to_many :users
  embeds_many :ipa_apps
  embeds_many :apk_apps

end
