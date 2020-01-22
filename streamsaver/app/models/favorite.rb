class Favorite < ApplicationRecord
    belongs_to :show
    belongs_to :user

    def self.all_months
        ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    end
end
