class User < ApplicationRecord
    has_secure_password
    has_many :entries, dependent: :destroy

    validates :username, presence: true, uniqueness: true
    validates :password, presence: true
end
