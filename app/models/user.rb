class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 一覧画面で使用
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  has_one_attached :profile_image

  validates :name, uniqueness: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: {maximum: 50}


  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  # フォローした時の処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  
  # フォローを外す時の処理
  
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  
  # フォローしているかの判定
  def following?(user)
    followings.include?(user)
  end
end
