class User < ApplicationRecord
    has_secure_password

    validates :firstName, presence: true
    validates :lastName, presence: true
    validates :email, presence: true, uniqueness: true
    has_many :contents, dependent: :destroy
    
end
