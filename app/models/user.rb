class User < ApplicationRecord
  validates :fname, :email, presence: true
  validates :email, uniqueness: true
  validates :phnum, numericality: { only_integer: true }
end
