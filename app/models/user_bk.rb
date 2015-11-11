class User < ActiveRecord::Base
  has_many :userhope, dependent: :destroy
  has_many :proposals
  has_many :properties, through: :proposals
  has_many :likes, class_name: "Proposal", foreign_key: "user_id", dependent: :destroy
  has_many :like_properties , through: :likes, source: :property
  has_many :dislikes, class_name: "Proposal", foreign_key: "user_id", dependent: :destroy
  has_many :dislike_properties , through: :dislikes, source: :property
  has_many :wanttosees, class_name: "Proposal", foreign_key: "user_id", dependent: :destroy
  has_many :wanttosee_properties , through: :wanttosees, source: :property
  has_many :nonevaluations, class_name: "Proposal", foreign_key: "user_id", dependent: :destroy
  has_many :nonevaluation_properties , through: :nonevaluations, source: :property
  has_many :deletes, class_name: "Proposal", foreign_key: "user_id", dependent: :destroy
  has_many :delete_properties , through: :deletes, source: :property

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable, :omniauthable,omniauth_providers: [:facebook]
  # omniauth_providers: [:twitter],

  def self.from_omniauth(auth)
    where(provider: auth["provider"], uid: auth["uid"]).first_or_create do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.email = auth["info"]["email"]
      user.password = Devise.friendly_token[0,20]
      if auth["provider"] == "facebook"
        user.username = auth["info"]["name"]
      elsif auth["provider"] == "twitter"
        user.username = auth["info"]["nickname"]
      end
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



  ## TODO 実装
  def like(property)
    likes.find_or_create_by(property_id: property.id)
    if nonevaluations.find_by(property_id: property.id)
      nonevaluations.destroy(property_id: property.id)
    elsif dislikes.find_by(property_id: property.id)
      dislikes.destroy(property_id: property.id)
    else


    end
  end
end
