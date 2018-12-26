# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  avatar                 :string
#  boards_count           :integer          default(0), not null
#  comment_count          :integer          default(0), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string           not null
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

FactoryBot.define do
  factory :user, aliases: [:owner] do
    sequence(:email) { |n| "tester#{n}@example.com" }
    sequence(:password) {|n| "dottle-nouveau-pavi#{n}lion-tights-furze"}
    sequence(:encrypted_password) {|n| "dottle-nouveau-pavi#{n}lion-tights-furze"}
    sequence(:name) { |n| "test#{n}" }
  end
end
