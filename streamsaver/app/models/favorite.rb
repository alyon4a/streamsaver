class Favorite < ApplicationRecord
    belongs_to :show
    belongs_to :user

    def self.all_months
        ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    end

    def self.parse_months(favorites_to_months)
        
        groomed_favorites_to_month = favorites_to_months.keys.reduce({}) do |memo, fav_id_month|
            indexes = fav_id_month.split("_")
            favorite = Favorite.find(indexes[0].to_i)
            month = all_months[indexes[1].to_i]
            memo[favorite] = [] if memo[favorite] == nil
            memo[favorite] << month
            memo
        end
        groomed_favorites_to_month.each do |favorite, months|
            favorite.months = months.join(',')
            favorite.save
        end
    end

    def months_array
        self.months.split(',')
    end

    def self.shows(favorites)
        favorites.map {|favorite| favorite.show }
    end

    # def self.months_to_string(months_array)
    #     months_array.to_s
    # end
end
