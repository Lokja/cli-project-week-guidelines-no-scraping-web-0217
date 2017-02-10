class MTGModel

  attr_reader :colors, :cmc, :types, :all_cards

  def initialize(colors, cmc, types, all_cards)
    @colors = colors
    @cmc = cmc
    @types = types
    @all_cards = all_cards
  end

  def compare
    @all_cards.find_all do |card|

      card["colors"] == @colors && card["cmc"] == @cmc && card["types"] == @types
      #binding.pry
    end
  end



end
