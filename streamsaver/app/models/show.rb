class Show < ApplicationRecord
    belongs_to :provider
    has_many :favorites
    has_many :users, through: :favorites
end
