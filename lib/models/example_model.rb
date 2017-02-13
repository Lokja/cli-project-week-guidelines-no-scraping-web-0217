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
    #binding.pry
    @all_cards = all_cards
  end
  #
  # def normalizetypes
  #   if @types.include?("legendary")
  #     @supertypes = ["legendary"]
  #     @types.delete("legendary")
  #   end
  # end

  def compare

    #--- TEST START ---#
    # test_card = {
    #   "name" =>"Forest",
    #   "colorIdentity" =>[
    #     "G"
    #   ],
    #   "type" =>"Basic Land — Forest",
    #
    #   "types" =>[
    #     "Creature"
    #   ]}
    # @all_cards = []
    # @all_cards << test_card
    #--- TEST END ---#

    @all_cards.find_all do |card|
      #normalizetypes
      #binding.pry
      if !card.has_key?("supertypes")
        card["supertypes"] = []
      elsif !@orig_types.include?("legendary")
        card["supertypes"] = []
        @supertypes = []
      end

      if !card.has_key?("cmc")
        card["cmc"] = 0
      end

      #binding.pry
      if !card.has_key?("colorIdentity")
        card["colorIdentity"] = []
      end
      #binding.pry
      card["colorIdentity"].sort == convertToID.sort && card["cmc"] == @cmc && card["types"].map{|v| v.downcase} == @types.map{|v| v.downcase}.sort && card["supertypes"].map{|v| v.downcase}.sort == @supertypes.map{|v| v.downcase}.sort
    end
    #binding.pry
  end

  def convertToID
    if @colors == ['none']
      @colors = []
    else
      @colors.map{|v| v.downcase == "blue" ? "U" : v[0].upcase} #changed to terneray
    end
  end

end
