class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile

  has_many :events, foreign_key: "user_id"

  has_many :subscriptions, through: :active_relationships, source: :subscribed
  has_many :active_relationships, class_name:  "Subscription", foreign_key: "subscriber_id", dependent: :destroy

  def self.from_omniauth(auth)
  	where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  		user.provider = auth.provider
  		user.uid = auth.uid
      user.username = auth.info.nickname
      user.profile_image = auth.info.image
  	end
  end

  def self.new_with_session(params, session)
  	if session["devise.user_attributes"]
  		new(session["devise.user_attributes"], without_protection: true) do |user|
  			user.attributes = params
  			user.valid?
  		end
  	else
  		super
  	end
  end

  # Subscribes to an event.
  def subscribe(event)
    active_relationships.create(subscribed_id: event.id)
  end

  # Unsubscribes to an event.
  def unsubscribe(event)
    active_relationships.find_by(subscribed_id: event.id).destroy
  end

  # Returns true if the current user is subscribed to the event.
  def subscribed?(event)
    subscriptions.include?(event)
  end

  def email_required?
    super && provider.blank?
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_email(params, *options)
    if email.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def update_with_password(params, *options)
  	if encrypted_password.blank?
  		update_attributes(params, *options)
  	else
  		super
  	end
  end

end
