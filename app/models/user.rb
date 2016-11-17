class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :level, optional: true
  has_many :bookings
  has_many :horses, dependent: :destroy
  has_many :horse_bookings, through: :horses, source: :bookings
  devise :omniauthable, omniauth_providers: [:facebook]
  # validates :first_name, presence: true
  # validates :last_name, presence: true
  after_create :send_welcome_email

  geocoded_by :address
  after_validation :geocode, if: :address_changed?


  def self.find_for_facebook_oauth(auth)
    user_params = auth.to_h.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)

    user = User.where(provider: auth.provider, uid: auth.uid).first
    user ||= User.where(email: auth.info.email).first # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user
  end

  def stars
    ratings = bookings.map { |booking| booking.user_rating}.select { |user_rating| !user_rating.nil? }
    rating = ratings.size > 0 ? ratings.sum.fdiv(ratings.size).round : 0
    ('<i class="fa fa-star" aria-hidden="true"></i>' * rating + '<i class="fa fa-star-o" aria-hidden="true"></i>' * (5 - rating)).html_safe
  end

  def past_bookings_count
    bookings.where('user_rating IS NOT NULL').count
  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end


end
