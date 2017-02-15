class MTGApi

  attr_accessor :all_cards, :pages
  BASE_URL = "https://api.magicthegathering.io/v1/cards?page="

  def initialize(page_range)
    @pages = page_range.to_a
    @all_cards = []
  end

  def get_card_array
    self.pages.each do |page|
      url = "#{BASE_URL}#{page}"
      page_data = JSON.parse(RestClient.get(url))
      pg_cards = page_data["cards"]
      @all_cards += pg_cards
    end
    self.all_cards
  end
end
