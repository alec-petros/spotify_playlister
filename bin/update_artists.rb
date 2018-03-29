require_relative '../config/environment.rb'
Artist.all.each do |artist|
  spot_artist = RSpotify::Artist.find(artist.spot_id)
  artist.popularity = spot_artist.popularity
  artist.images = spot_artist.images
  artist.save
  puts "#{artist.name} - #{artist.images[0]["url"]}"
end
