# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  avatar                 :string
#  boards_count           :integer          default(0), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string           not null
#  point                  :integer          default(5), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_name                  (name) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  has_many :boards, dependent: :delete_all
  has_many :comments, dependent: :delete_all

  validates :name,
    presence: true,
    length: { maximum: 30 },
    uniqueness: { case_sensitive: false }

  validates :point,
    presence: true,
    numericality: { only_integer: true,
    greater_than_or_equal_to: 0 }

  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  def lose_point!
    self.point -= 1
    self.save!
  end
end
