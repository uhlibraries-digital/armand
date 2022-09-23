class User < ApplicationRecord
  # Connects this user object to Hydra behaviors.
  include Hydra::User

  # Connects this user object to Hyrax behaviors.
  include Hyrax::User
  include Hyrax::UserUsageStats

  if Blacklight::Utils.needs_attr_accessible?
    attr_accessible :email, :password, :password_confirmation
  end
  # Connects this user object to Blacklights Bookmarks.
  include Blacklight::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  if Settings.saml.active
    devise :saml_authenticatable
  else
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
  end

  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account.
  def to_s
    email
  end

  def self.find_or_create_system_user(user_key)
    if Settings.saml.active
      User.find_by_user_key(user_key) || User.create!(Hydra.config.user_key_field => user_key)
    else
      User.find_by_user_key(user_key) || User.create!(Hydra.config.user_key_field => user_key, password: Devise.friendly_token[0, 20])
    end
  end

end
