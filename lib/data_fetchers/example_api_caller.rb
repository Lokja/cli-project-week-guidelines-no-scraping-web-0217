# class ExampleApi
#
#   attr_reader :url, :music_data
#
#   def initialize(url)
#     @url = url
#     @music_data = JSON.parse(RestClient.get(url))
#   end
#
#   def make_albums
#     albums = []
#     pg_albums = music_data["tracks"]["items"]
#     all_albums.each do |album|
#       album_name = album["name"]
#       albums << ExampleModel.new(album_name)
#     end
#     albums
#   end
#
# end





class MTGApi

  attr_reader :card_data, :url

  def initialize(url)
    @card_data = JSON.parse(RestClient.get(url))
    puts "Searching the Multiverse..."
  end


  def make_card_arr
    pg_cards = @card_data["cards"] #an array of 100 hashes of cards
    pg_cards.find_all{|card| card["set"] == "LEA"}
  end

end
    # PAGES.each do |page|
    #     url = "https://api.magicthegathering.io/v1/cards?page=#{page}"














# def get_films_from_api(films_array)
#   films_array.map do |film|
#     film_req = RestClient.get(film)
#     film_hash = JSON.parse(film_req)
#   end
# end
#
# def merged_char_arr
#   character_arr = []
#   url = "http://www.swapi.co/api/people/?page=1"
#   begin
#     pg_characters = RestClient.get(url)
#     pg_hash = JSON.parse(pg_characters)
#     character_arr += pg_hash["results"]
#     url = pg_hash["next"]
#   end while url
#   character_arr
# end
