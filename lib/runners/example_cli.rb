class MTGCLI

  def call
    puts "Welcome to the MtG Alpha to 5ED Search CLI Application"
    run
  end

  COLORS = ["black", "blue", "green", "red", "white", "none"]
  TYPES = ["artifact", "creature", "enchantment", "instant", "sorcery", "land", "legendary"]

  def input
    gets.chomp.strip.downcase
  end

  def colorsm
    color = input.split(" ")
    color.each do |word|
      if !COLORS.include?(word)
        puts "Invalid Input, please try again"
        colorsm
      end
    end
    color
  end

  def typesm
    type = input.split(" ")
    type.each do |word|
      #binding.pry
      if !TYPES.include?(word)
        puts "Invalid Input, please try again"
        typesm
      end
    end
    type
  end

  def get_user_input
    puts "Please enter a color:"
    puts "Black, Blue, Green, Red, White, or none for artifacts:"
    colors = colorsm
    puts "Please enter the converted mana cost:"
    cmc = gets.chomp.strip.to_i
    puts "Please enter a Card Type (Creature, Land, Artifact, etc.)"
    types = typesm
    {colors: colors, cmc: cmc, types: types}
  end

  def run
    puts "Ready? Please type 'start' to begin. Otherwise type 'help' or 'exit'."
    input = gets.chomp
    if input.downcase == "help"
      help
    elsif input.downcase == "exit"
      puts "See you on the battlefield, Planeswalker"
      exit
    elsif input.downcase == "start"
      card_inputs = get_user_input
      get_cards(card_inputs[:colors], card_inputs[:cmc], card_inputs[:types])
    else
      puts "Did not recognize your input. Please try again"
    end
    run
  end

  PAGES = (1..3).to_a

  def get_cards(colors, cmc, types)
    all_cards = []

    PAGES.each do |page|
      url = "https://api.magicthegathering.io/v1/cards?page=#{page}"
      all_cards += MTGApi.new(url).make_card_arr
    end
    #binding.pry
    found_cards = MTGModel.new(colors, cmc, types, all_cards).compare
    #binding.pry
    puts "Thank you for your patience. I found these cards:"
    names = []
    found_cards.each do |card|
      names << card["name"]
    end
    names.uniq.each{|name| puts name}
    if found_cards == []
      puts "Couldn't find any cards with those parameters, please try again."
    end
  end

  def help
    puts "Type 'exit' to exit"
    puts "Type 'help' to view this menu again"
    puts "Type anything else to search for a cards"
  end

end
