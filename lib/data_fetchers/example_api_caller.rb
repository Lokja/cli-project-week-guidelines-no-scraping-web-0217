class MTGApi

  attr_reader :card_data, :url

  def initialize(url)
    @card_data = JSON.parse(RestClient.get(url))
  end

  def make_card_arr
    pg_cards = @card_data["cards"]
  end

end
