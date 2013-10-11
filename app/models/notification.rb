class Notification
  include Mongoid::Document

  #Fields
  field :state
  field :updatetime, :type => Time

  #Transitions for state field finite state machine
  state_machine :state, initial: :initialized do
    after_transition any => :initialized, :do => :send_mail
    event :send do
      transition :initialized => :email_sent
    end

    event :read do
      transition :email_sent => :email_read
    end

    event :clicked do
      transition :email_read => :app_installed
    end
  end

  #Associations
  belongs_to :user
  belongs_to :apkbuild
  belongs_to :ipabuild

  #Methods

  def initialize
    self.update_updatetime
    super()
  end

  def send_mail
    @user = User.where(:_id => self.user_id)
    RestClient.post(messaging_api_end_point,
      from: "myself@testdistributor.mailgun.org",
      to: @user.email,
      subject: "Test mail",
      html: "Test mail"
    )
    self.send
    self.update_updatetime
  end

  def update_updatetime
    self.updatetime = Time.now
  end

  private

  def api_key
    @api_key ||= ENV["MAILGUN_API_KEY"]
  end

  def mailgun_api_domain
    @mailgun_api_domain ||= ENV["MAILGUN_API_DOMAIN"]
  end

  def messaging_api_end_point
    @messaging_api_end_point ||= "https://api:#{api_key}@api.mailgun.net/v2/#{mailgun_api_domain}/messages"
  end

end
