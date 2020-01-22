class Show < ApplicationRecord
    belongs_to :provider
    has_many :favorites
    has_many :users, through: :favorites

    def self.shows_by_provider(shows)
        shows.inject({}) do |providers_to_shows, show|
            provider = show.provider
            providers_to_shows[provider.name] = [] if providers_to_shows[provider.name] == nil
            providers_to_shows[provider.name] << show
            providers_to_shows
        end
    end

    def self.all_shows_by_provider
        shows_by_provider(Show.all)
    end
end
