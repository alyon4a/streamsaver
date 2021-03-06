class Favorite < ApplicationRecord
    belongs_to :show
    belongs_to :user

    def self.all_months
        ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    end

    def self.full_month(month)
        full_months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        full_months.select{|mon| 
            Favorite.all_months.find_index(month) == full_months.find_index(mon)}[0]
    end 

    def self.next_month(month)
        index = Favorite.all_months.find_index(month)
        if index == 11 
            new_index = 0 
        else 
            new_index = index + 1
        end 
        Favorite.all_months[new_index]
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

    def self.month_to_number(month)
        self.all_months.find_index(month) + 1
    end 
    def self.number_to_month(number)
        self.all_months[number - 1]
    end

end
