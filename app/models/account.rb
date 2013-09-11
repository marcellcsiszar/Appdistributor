class Account
  include Mongoid::Document
  field :uid, type: String
  field :username, type: String
  field :oauth_token, type: String
  field :oauth_secret, type: String
  field :oauth_expires, type: Time
  # Egy a többhöz kapcsolat
  embedded_in :user
end
