class MTGCLI

  def call
    puts "Welcome to the MtG Alpha Search CLI Application"
    run
  end

  def get_user_input
    puts "Please enter a color:"
    puts "Example: Black, Blue, White"
    colors = gets.chomp.strip.split
    puts "Please enter the converted mana cost:"
    cmc = gets.chomp.strip.to_i
    puts "Please enter a Card Type (Creature, Land, Artifact, etc.)"
    types = gets.chomp.strip.split(" ")
    {colors: colors, cmc: cmc, types: types}
  end

  def run
    puts "Ready? Please type 'start' to begin. Otherwise type 'help' or 'exit'."
    input = gets.chomp
    if input == "help"
      help
    elsif input == "exit"
      puts "See you on the battlefield, Planeswalker"
      exit
    elsif input == "start"
      card_inputs = get_user_input
      get_cards(card_inputs[:colors], card_inputs[:cmc], card_inputs[:types])
    else
      puts "Did not recognize your input. Please try again"
    end
    run
  end

  PAGES = [1,2,3]

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
    found_cards.each do |card|
      puts card["name"]
      puts card["imageUrl"]
    end
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
