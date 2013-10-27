class Notification
  include Mongoid::Document

  #Fields
  field :state
  field :updatetime, :type => Time
  field :mailgun_message_id
  field :platform
  field :app_name
  field :downlink

  #Transitions for state field finite state machine
  state_machine :state, initial: :initialized do
    event :delivery_mail do
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
  def initialize(params)
    super()
    self.update_updatetime
    self.ipabuild_id = params[:ipabuild_id] if params.has_key?(:ipabuild_id)
    self.apkbuild_id = params[:apkbuild_id] if params.has_key?(:apkbuild_id)
    self.platform = params[:platform]
    self.user_id = params[:user_id]
    self.app_name = params[:app_name]
    self.downlink = params[:downlink]
    self.send_mail
  end

  def identify_mailgenerator
      case platform
        when "apk"
          return apk_mailgenerator
        when "ipa"
          return ipa_mailgenerator
        else
          return "Bad buildpackage"
      end
  end

  def apk_mailgenerator
    return self.downlink
  end

  def ipa_mailgenerator
    @html = '<a href="itms-services://?action=download-manifest&amp;url='+self.downlink+'">'+I18n.t('application.notifications.email.body')+'</a>'
    return @html
  end

  def send_mail
    @user = User.find(self.user_id)
    RestClient.post(messaging_api_end_point,
      from: "app@testdistributor.mailgun.org",
      to: "marco1991@freemail.hu",
      subject: I18n.t('application.notifications.email.title') + self.app_name,
      html: identify_mailgenerator,
      "o:tracking-clicks" => "yes"
      ){ |response, request, result, &block|
      self.mailgun_message_id = response.split("\n")[2].split(":")[1].strip[2..-3]
  }
    self.delivery_mail
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
