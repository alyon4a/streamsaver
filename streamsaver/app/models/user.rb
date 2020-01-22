class User < ApplicationRecord
    has_secure_password
    has_many :favorites
    has_many :shows, through: :favorites

    validates :first_name, presence: true, length: {maximum: 15}
    validates :last_name, presence: true, length: {maximum: 15}
    validates :password, presence: true, length: {in: 5..15 }
    validates :password, confirmation: { case_sensitive: true}
    validates :email, presence: true, uniqueness: {case_sensitive: false}, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :phone_number, presence: true, format: { with: /\A\d{3}-\d{3}-\d{4}\z/, 
        message: "must be in xxx-xxx-xxxx format."}


    def shows_by_provider
        self.favorites.inject({}) do |providers_shows, favorite|
            provider = favorite.show.provider
            providers_shows[provider.name] = [] if providers_shows[provider.name] == nil
            providers_shows[provider.name] << favorite.show
            providers_shows
        end

    end

end
