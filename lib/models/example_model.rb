class MTGModel

  attr_accessor :cards_array, :types, :colors, :cmc

  def initialize(colors, cmc, types, cards_array)
    @colors = colors
    @cmc = cmc
    @types = types
    @cards_array = cards_array

    #@orig_types = types
    #@types = []
    # types.each{|e| @types << e.dup}
    # @supertypes = []
    # if @types.include?("legendary")
    #   @supertypes = ["legendary"]
    #   @types.delete("legendary")
    # end
  end

  # "name"=>"Swamp",
  #  "colorIdentity"=>["B"],
  #  "type"=>"Basic Land — Swamp",
  #  "supertypes"=>["Basic"],
  #  "types"=>["Land"],
  #  "subtypes"=>["Swamp"],
  #  "rarity"=>"Basic Land",
  #  "set"=>"DDP",
  #  "setName"=>"Duel Decks: Zendikar vs. Eldrazi",
  #  "artist"=>"Véronique Meignaud",
  #  "number"=>"70",
  #  "layout"=>"normal",
  #  "multiverseid"=>401712,
  #  "imageUrl"=>
  #   "http://gathere
 #
 #  {"name"=>"Ulamog, the Ceaseless Hunger",
 # "manaCost"=>"{10}",
 # "cmc"=>10,
 # "type"=>"Legendary Creature — Eldrazi",
 # "supertypes"=>["Legendary"],
 # "types"=>["Creature"],
 # "subtypes"=>["Eldrazi"],
 # "rarity"=>"Mythic Rare",
 # "set"=>"BFZ",
 # "setName"=>"Battle for Zendikar",
 # "text"=>
 # {"name"=>"Drana, Liberator of Malakir",
 # "manaCost"=>"{1}{B}{B}",
 # "cmc"=>3,
 # "colors"=>["Black"],
 # "colorIdentity"=>["B"],
 # "type"=>"Legendary Creature — Vampire Ally",
 # "supertypes"=>["Legendary"],
 # "types"=>["Creature"],
 # "subtypes"=>["Vampire", "Ally"],
 # "rarity"=>"Mythic Rare",
 # "set"=>"BFZ",
 # "setName"=>"Battle for Zendikar",
 # "text"=>


  def handle_legendary(card)
    if card.has_key?("supertypes") && @types.include?("legendary")
      if card["supertypes"][0].downcase=="legendary"
        card["types"] += card["supertypes"]
      end
    end
  end

  def compare
    @cards_array.find_all do |card|
      # if !card.has_key?("supertypes")
      #   card["supertypes"] = []
      # elsif !@orig_types.include?("legendary")
      #   card["supertypes"] = []
      #   @supertypes = []
      # end
      handle_legendary(card)
      if !card.has_key?("cmc")
        card["cmc"] = 0
      end
      if !card.has_key?("colorIdentity")
        card["colorIdentity"] = []
      end
      card["colorIdentity"].sort == reformat_color.sort && card["cmc"] == @cmc && card["types"].map{|v| v.downcase} == @types.map{|v| v.downcase}.sort #&& card["supertypes"].map{|v| v.downcase}.sort == @supertypes.map{|v| v.downcase}.sort
    end
  end

  def reformat_color
    if @colors == ['none']
      @colors = []
    else
      @colors.map{|v| v.downcase == "blue" ? "U" : v[0].upcase}
    end
  end

end
