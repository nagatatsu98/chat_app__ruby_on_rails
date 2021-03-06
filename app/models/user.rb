class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :profile, length: { maximum: 1000 }
  has_secure_password
  
  mount_uploader :image, ImageUploader
  
  has_many :groups
  has_many :subscribers
  has_many :subscribed_groups, through: :subscribers, source: :group
  
  has_many :messages
end
