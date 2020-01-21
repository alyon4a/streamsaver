class Provider < ApplicationRecord
    has_many :shows

    validates :name, presence: true, length: {maximum: 15}
    validates :cost, presence: true, numericality: {greater_than: 0}
    validates :url, presence: true, uniqueness: {case_sensitive: true}

end
