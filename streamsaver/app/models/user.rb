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
        Show.shows_by_provider(self.shows)
    end

    #Helper method creates a hash of show names pointing to an array of months the user selected
    def shows_by_month 
        new_hash = self.favorites.reduce({}) do |shows, favorite|
            shows[favorite.show] = favorite.months_array
            shows
        end
    end


    def display_shows(month, current)
        current_shows = []
        future_shows = []
        self.shows_by_month.each do |show, month_array|
            if month_array.include?(month)
                current_shows << show
            else 
                future_shows << show
            end  
        end 
        if current
            current_shows 
        else 
            future_shows 
        end 
    end 



end
