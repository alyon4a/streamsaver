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
    def favorites_by_month 
        new_hash = self.favorites.reduce({}) do |favorites_hash, favorite|
            favorites_hash[favorite] = favorite.months_array
            favorites_hash
        end
    end


    def display_favorites(month, current)
        current_favorites = []
        next_favorites = []
        future_favorites = []
        self.favorites.each do |favorite|
            months = favorite.months.split(",")
            # next_months = months.map do |month|
            #     new_index = Favorite.all_months.find_index(month) + 1
            #     Favorite.all_months[new_index]
            # end 
            next_month = Favorite.next_month(month)
            if months.include?(month)
                current_favorites << favorite
            elsif months.include?(next_month)
                next_favorites << favorite
            else   
                future_favorites << favorite
            end 
        end 
        if current == "current"
            current_favorites
        elsif current == "next"
            next_favorites
        elsif current == "future"
            future_favorites
        end
    end 

    def get_reminders(month, day)
       expiring_favorites = expiring_favorites(month, day)
       show_names = expiring_favorites.map {|favorite| favorite.show.name}
       provider_names = expiring_providers(expiring_favorites)
       reminder = []
       days_left = Time.days_in_month(month) - day.to_i
       if show_names != [] && day.to_i > 15
            shows = show_names.join(", ")
            reminder << "#{shows} will expire soon. You have <strong>#{days_left} days</strong> left to watch!"
       end 
       if provider_names != []
            providers = provider_names.join(", ")
            reminder << "You don't need <strong>#{providers}</strong> next month. Remember to deactivate your subscription in <strong>#{days_left} days</strong>."
       end
       reminder
    end 

    #Helper method to return a hash of of expiring shows (the key is the show and the value is its array of months)
    def expiring_favorites(month, day)
        favorite_hash = self.favorites_by_month.select do |favorite, month_array|
            Favorite.month_to_number(month_array.last) == month 
        end
        favorite_hash.keys
    end 

    #Helper method to get expiring providers by crossreferencing the hash of shows organized by providers against the list of shows expiring this month
    def expiring_providers(expiring_favorites)
        providers = []
        expiring_shows = expiring_favorites.map {|favorite| favorite.show}
        shows_by_provider.each do |provider, show_array|
            shows_in_common = show_array.select do |show|
                expiring_shows.include?(show)
            end
            if !shows_in_common.empty?
                providers << provider 
            end 
        end 
        providers
    end 

end
