class MTGModel

  attr_accessor :cards_array, :types, :colors, :cmc

  def initialize(colors, cmc, types, cards_array)
    @colors = colors
    @cmc = cmc
    @types = types
    @cards_array = cards_array
  end

  def handle_legendary(card)
    if card.has_key?("supertypes") && @types.include?("legendary")
      if card["supertypes"][0].downcase=="legendary"
        card["types"] += card["supertypes"]
      end
    end
  end

  def compare
    #@cards_array = [{"name" => "Black Lotus", "printings" => ["LEA"], "types" => ["Artifact"]}]
    @cards_array.find_all do |card|
      handle_legendary(card)
      initializeEmptyVars(card)
      card["colorIdentity"].sort == reformat_color.sort && card["cmc"] == @cmc && card["types"].map{|v| v.downcase}.sort == @types.map{|v| v.downcase}.sort
    end
  end

  def reformat_color
    if @colors == ['none']
      @colors = []
    else
      @colors.map{|v| v.downcase == "blue" ? "U" : v[0].upcase}
    end
  end

  def initializeEmptyVars(card)
    card["cmc"] ||= 0
    card["colorIdentity"] ||= []
  end

end
