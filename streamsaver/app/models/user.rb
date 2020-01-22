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

    def get_reminders(month, day)
       expiring_shows = expiring_shows(month, day)
       show_names = expiring_shows.map {|show| show.name}
       provider_names = expiring_providers(expiring_shows)
       reminder = []
       days_left = Time.days_in_month(month) - day
       if show_names != [] && day > 15
            shows = show_names.join(", ")
            reminder << "#{shows} will expire soon. You have #{days_left} days left to watch!"
       else 
            reminder << "Welcome, #{self.first_name}!"
       end 
       if provider_names != []
            providers = provider_names.join(", ")
            reminder << "You don't need #{providers} next month. Remember to deactivate your subscription in #{days_left} days."
       end
       reminder
    end 

    #Helper method to return a hash of of expiring shows (the key is the show and the value is its array of months)
    def expiring_shows(month, day)
        show_hash = self.shows_by_month.select do |tv_show, month_array|
            Favorite.month_to_number(month_array.last) == month 
        end
        show_hash.keys
    end 

    #Helper method to get expiring providers by crossreferencing the hash of shows organized by providers against the list of shows expiring this month
    def expiring_providers(expiring_shows)
        providers = []
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
