class MTGCLI

  attr_accessor :cards_array, :fetch_caller, :colors, :cmc, :types, :output, :api_caller

  def initialize
    @fetch_caller = MTGFetch.new
    @api_caller = MTGJSONCaller.new
    @cards_array = []
  end

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
    puts "========================================================"
    puts "      Welcome to the MtG CLI Search Application"
    puts "========================================================"
    puts ""
    puts ""

    puts "The local version is #{@fetch_caller.local_version}."
    puts "The live version is #{@api_caller.live_version}."

    if @fetch_caller.local_version == @api_caller.live_version
      puts "Up to date."
    else
      puts "You're using an outdated database, would you like to update? (Y/N)"
      ui = gets.chomp.strip.downcase[0]
      if ui == "y"
        @api_caller.update
        call
      end
    end
    start
  end

  COLORS = ["black", "blue", "green", "red", "white", "none"]
  TYPES = ["artifact", "creature", "enchantment", "instant", "sorcery", "land", "legendary", "planeswalker"]
  CMCS = (0..15)


  def start
    puts "--------------------------------------------------------------------"
    puts "Ready? Please type 'start' to begin. Otherwise type 'help' or 'exit'."
    input = check_answers()
    start
  end

  def get_user_input
    puts ""
    puts "Please enter a color identity:"
    puts "Black, Blue, Green, Red, White, or none for colorless:"
    @colors = check_answers(COLORS)
    puts ""
    puts "Please enter the converted mana cost:"
    @cmc = check_answers(CMCS)
    puts ""
    puts "Please enter a Card Type (Creature, Land, Artifact, etc.)"
    @types = check_answers(TYPES)
    puts ""
    puts "Searching the Multiverse..."
  end

  def check_answers(question = nil)
    answer = input
    if answer == "help"
      puts "Pulling up help options"
      puts ""
      sleep(1)
      help
      sleep(2)
      puts ""
      start
    elsif answer == "exit"
      puts "See you on the battlefield, Planeswalker"
      exit
    elsif answer == "start" || answer == "restart"
      sleep(1)
      get_user_input
      get_cards
      get_card_info
      results
  #    user_inputs = get_user_input
  #    get_cards(user_inputs[:colors], user_inputs[:cmc], user_inputs[:types])
    elsif question == TYPES || question == COLORS
      answer = answer.split(" ")
      if answer.all? {|i| question.include?(i)}
        answer
      else
        invalid_input(question)
      end
    elsif question == CMCS
      answer = Integer(answer) rescue false
       if !!answer
        answer
      else
        invalid_input(question)
      end
    else
      invalid_input(question)
    end
  end

  def invalid_input(question = nil)
    puts "Invalid Input, please try again"
    check_answers(question)
  end

  def input
    gets.chomp.strip.downcase
  end

  def get_cards
    self.cards_array = self.fetch_caller.get_card_array
  end

  def find_cards
    #binding.pry
    MTGModel.new(self.colors, self.cmc, self.types, self.cards_array).compare

  end

  def get_card_info
    card_info = []
    found_cards = self.find_cards
    #binding.pry
    found_cards.each do |card|
      card_info << "#{card["name"]} - #{card["setName"]}"
    end
    @output = card_info.uniq
  end

  def results
    puts ""
    if self.output == []
      puts "Couldn't find any cards with those parameters, please try again."
      puts ""
    else
      puts "Thank you for your patience. I found these cards:"
      self.output.each do |card|
        puts card
      end
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
