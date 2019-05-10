class Question < ActiveRecord::Base

  has_many :answers, dependent: destroy
  belongs_to :asker, class_name: 'User', foreign_key: 'user_id'

  validates :title, presence: true
end
