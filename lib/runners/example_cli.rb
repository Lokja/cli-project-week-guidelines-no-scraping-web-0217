class MTGCLI

  def call
    puts "
                 `.-://+osssso++/:-.`
             .:+syhdmNNNNNNNNNNmdhys+:.`
          ./oydNNNNNNNNNNNNNNNNNNNNNNdyo/.
        -+sdNNNNNNNNmdhyyyyyyhdmNNNNNNNNds+-
      .+sdNNNNNNmyo//////////////oydNNNNNNms+.
     :ohNNNNNNh+///::::::::::::::////smNNNNNdo/`
   `/smNNNNNho+++////::::::::+o+++ooo+/smNNNNms+`
   +sNNNNNmohNNNNNNNNs------:ymNNNNNNh///dNNNNNs+`
 :omNNNNm+///yNNNNNNNs--------+NNNNNd:///hNNNNmo/
 .ohNNNNN+//:/mNNNNNNNNy------+mNNNNNNo:///dNNNNho.
 :oNNNNNy//::hNNNymNNNNNd/---+NNNNNNNNN+://oNNNNNo/
+sNNNNN+//:osyy/--oNNNNNNymmhossmNNNNNm+///NNNNNso
+sNNNNN//:sNNN+----/mNNNNNNNd:--:mNNNNNN+/+NNNNNyo
+sNNNNN+/+NNNh------/NNNNNNN/----/mNNNNNm++NNNNNso
:oNNNNNy/dNNd:-------+NNNNNN+-----/NNNNNNd/hNNNNo/
.ohNNNNosNNm/::-------hNNNNNd:-----+NNNNNNy+NNNho.
 :omNmosNNNh::::------/NNNNNNy----::dNNNNNNsoydo/
  /shoyNNNNNy/:::::----dNNNNNm:-::+hNNNNNNNNdso+`
  `/odNhyyyys+/::::::::yNNNh+::::sNmhyhyysyhds+`
    :osmNNNNNho///:::::odd/:::::///ohNNNNNNho/`
     .+sdNNNNNNmhs+////////////+shmNNNNNNms+.
       -+sdNNNNNNNNNmdhyyyyhhdNNNNNNNNNds+-
         ./oydNNNNNNNNNNNNNNNNNNNNNNdyo/.
            .:+oyhdmNNNNNNNNNNmdhys+:.
                .-://+oossoo+//:-.`
"
  puts "======================================================"
  puts "Welcome to the MtG Alpha to 5ED Search CLI Application"
  puts "======================================================"
    run
  end

  COLORS = ["black", "blue", "green", "red", "white", "none"]
  TYPES = ["artifact", "creature", "enchantment", "instant", "sorcery", "land", "legendary"]
  PAGES = (1..50).to_a

  def input
    gets.chomp.strip.downcase
  end

  def colorsm
    color = input.split(" ")
    color.each do |word|
      if word.downcase == "exit"
        puts "See you on the battlefield, Planeswalker"
        exit
      elsif !COLORS.include?(word)
        puts "Invalid Input, please try again."
        colorsm
      end
    end
    color
  end

  def typesm
    type = input.split(" ")
    type.each do |word|
      #binding.pry
      if word.downcase == "exit"
        puts "See you on the battlefield, Planeswalker"
        exit
      elsif !TYPES.include?(word)
        puts "Invalid Input, please try again."
        typesm
      end
    end
    type
  end

  def cmcm
    cmc = input.to_i
    if cmc.class == String && cmc == "exit"
      puts "See you on the battlefield, Planeswalker"
      exit
    elsif cmc.class != Fixnum
      puts "Invalid Input, please try again."
      cmcm
    end
    cmc
  end

  def get_user_input
    puts "Please enter a color identity:"
    puts "Black, Blue, Green, Red, White, or none for colorless:"
    colors = colorsm
    puts "Please enter the converted mana cost:"
    cmc = cmcm
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
    names.uniq.each do |name|
      puts name
    end
    if found_cards == []
      puts "Couldn't find any cards with those parameters, please try again."
    end
  end

  def help
    puts "-- Type 'exit' to exit"
    puts "-- Type 'help' to view this menu again"
    puts "-- Type 'start' to begin searching for cards"
    puts "-- First enter one or more colors (not seperated by comma, i.e. blue green white)"
    puts "      Available colors are: 'black', 'blue', 'green',"
    puts "      'red', 'white',or 'none' for colorless cards"
    puts "-- Next enter a converted mana cost between 1 and 13"
    puts "-- Last enter one or more card types (not seperated by comma, i.e legendary creature)"
    puts "     Available types are: 'artifact', 'creature',"
    puts "     'enchantment', 'instant', 'sorcery', 'land', or 'legendary'"
  end

end
