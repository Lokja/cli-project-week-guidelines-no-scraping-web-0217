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
      #card = @all_cards.find{|card| card["name"]["Lady Caleria"]}
      #binding.pry
      if !@colors == "none"
        card["colorIdentity"].sort == convertToID.sort && card["cmc"] == @cmc && card["types"].map{|v| v.downcase}.sort == @types.map{|v| v.downcase}.sort
      else
        card["cmc"] == @cmc && card["types"].map{|v| v.downcase}.sort == @types.map{|v| v.downcase}.sort
      end
    end
  end

  def convertToID
    @colors.map do |v|
      if v.downcase == "blue"
        "U"
      else
        v[0].upcase
      end
    end
  end

end
