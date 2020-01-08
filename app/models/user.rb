class User < ApplicationRecord
    has_many :receipts

    validates :username, :email, :city, :country, :state, :contact_num, presence: true
    validates :email, format: /@/
    validates :email, :contact_num, uniqueness: true
    validates_uniqueness_of :email, scope: :username
end
