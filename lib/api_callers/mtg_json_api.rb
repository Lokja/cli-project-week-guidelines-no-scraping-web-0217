class MTGJSONCaller

  attr_accessor :live_version

  def live_version
    url = "http://mtgjson.com/json/version.json"
    RestClient.get(url).to_s
  end

  def self.update
    puts "UPDATING WOO"
  end

end
