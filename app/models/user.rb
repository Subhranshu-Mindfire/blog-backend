class User < ApplicationRecord
  has_secure_password
  has_many :allowed_lists, dependent: :destroy
end
