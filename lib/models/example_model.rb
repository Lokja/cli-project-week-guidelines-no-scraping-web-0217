class MTGModel

  attr_reader :colors, :cmc, :all_cards
  attr_accessor :supertypes, :types, :orig_types

  def initialize(colors, cmc, types, all_cards)
    @colors = colors
    @cmc = cmc
    @orig_types = types
    @types = []
    types.each{|e| @types << e.dup}
    @supertypes = []
    if @types.include?("legendary")
      @supertypes = ["legendary"]
      @types.delete("legendary")
    end
    @all_cards = all_cards
  end


  def compare

    @all_cards.find_all do |card|
      if !card.has_key?("supertypes")
        card["supertypes"] = []
      elsif !@orig_types.include?("legendary")
        card["supertypes"] = []
        @supertypes = []
      end
      if !card.has_key?("cmc")
        card["cmc"] = 0
      end
      if !card.has_key?("colorIdentity")
        card["colorIdentity"] = []
      end
      card["colorIdentity"].sort == convertToID.sort && card["cmc"] == @cmc && card["types"].map{|v| v.downcase} == @types.map{|v| v.downcase}.sort && card["supertypes"].map{|v| v.downcase}.sort == @supertypes.map{|v| v.downcase}.sort
    end
  end

  def convertToID
    if @colors == ['none']
      @colors = []
    else
      @colors.map{|v| v.downcase == "blue" ? "U" : v[0].upcase}
    end
  end

end
