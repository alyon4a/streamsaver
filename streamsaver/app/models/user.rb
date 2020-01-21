class User < ApplicationRecord
    has_many :favorites
    has_many :shows, through: :favorites

    validates :first_name, presence: true, length: {maximum: 15}
    validates :last_name, presence: true, length: {maximum: 15}
    validates :password, presence: true, length: {in: 5..15 }
    validates :email, presence: true, uniqueness: {case_sensitive: false}, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :phone_number, presence: true, format: { with: /\A\d{3}-\d{3}-\d{4}\z/, 
        message: "hone numbers must be in xxx-xxx-xxxx format."}

end
