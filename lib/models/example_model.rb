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
      initializeEmptyVars(card)
      card["colorIdentity"].sort == convertToID.sort && card["cmc"] == @cmc && card["types"].map{|v| v.downcase} == @types.map{|v| v.downcase}.sort && card["supertypes"].map{|v| v.downcase}.sort == @supertypes.map{|v| v.downcase}.sort
    end
  end

  def initializeEmptyVars(card)
    card["supertypes"] ||= []
    card["cmc"] ||= 0
    card["colorIdentity"] ||= []
    if !@orig_types.include?("legendary")
      card["supertypes"] = []
      @supertypes = []
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
