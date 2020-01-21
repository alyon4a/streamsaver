class User < ApplicationRecord
    has_many :favorites
    has_many :shows, through: :favorites
end
