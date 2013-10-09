class Ipaapp
  include Mongoid::Document

  ## Fields
  field :name, :type => String
  field :bundleID, :type => String
  field :autonotification, :type => Boolean

  ## Validators
  validates_uniqueness_of :name
  validates_presence_of :name

  validates_uniqueness_of :bundleID
  validates_presence_of :bundleID

  validates_presence_of :autonotification

  ## Associations
  embedded_in :project
  embeds_many :ipabuilds

end
