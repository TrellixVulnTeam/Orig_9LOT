class User < ActiveRecord::Base
  has_many :userhope, dependent: :destroy
  has_many :proposals
  has_many :properties, through: :proposals
  has_many :likes, class_name: "Like", foreign_key: "user_id", dependent: :destroy
  has_many :like_properties , through: :likes, source: :property
  has_many :dislikes, class_name: "Dislike", foreign_key: "user_id", dependent: :destroy
  has_many :dislike_properties , through: :dislikes, source: :property
  has_many :wanttosees, class_name: "Wanttosee", foreign_key: "user_id", dependent: :destroy
  has_many :wanttosee_properties , through: :wanttosees, source: :property
  has_many :nonevaluations, class_name: "Nonevaluation", foreign_key: "user_id", dependent: :destroy
  has_many :nonevaluation_properties , through: :nonevaluations, source: :property
  has_many :deletes, class_name: "Delete", foreign_key: "user_id", dependent: :destroy
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



  ## LIKE DISLIKE実装
  def like(property)
    likes.find_or_create_by(property_id: property.id)
    if nonevaluations.find_by(property_id: property.id)
      nonevaluations.destroy(property_id: property.id)
    end
    if dislikes.find_by(property_id: property.id)
      dislikes.destroy(property_id: property.id)
    end
  end

  def unlike(property)
    likes.find_by(property_id: property.id).destroy
  end
  def dislike(property)
    dislikes.find_or_create_by(property_id: property.id)
    if nonevaluations.find_by(property_id: property.id)
      nonevaluations.destroy(property_id: property.id)
    end
    if likes.find_by(property_id: property.id)
      likes.destroy(property_id: property.id)
    end
  end
  def undislike(property)
    dislikes.find_by(property_id: property.id).destroy
  end
  def unnonevaluation(property)
    nonevaluations.find_by(property_id: property.id).destroy
  end
  def wanttosee(property)
    wanttosees.find_or_create_by(property_id: property.id)
  end
  def unwanttosee(property)
    wanttosees.find_by(property_id: property.id).destroy
  end
  def like?(property)
    like_properties.include?(property)
  end
  def dislike?(property)
    dislike_properties.include?(property)
  end
  def wanttosee?(property)
    wanttosee_properties.include?(property)
  end
  def nonevaluation?(property)
    nonevaluation_properties.include?(property)
  end
end
