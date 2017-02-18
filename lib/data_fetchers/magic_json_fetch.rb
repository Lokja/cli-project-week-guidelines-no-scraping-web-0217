class MTGFetch

  def read_file(file)
    File.read("#{Dir.pwd}/json_data/#{file}")
  end

  def get_card_array
    file = "AllCards-x.json"
    JSON.parse(read_file(file)).map{|card| card[1]}
  end

  def local_version
    file = "version.json"
    read_file(file)
  end

end
