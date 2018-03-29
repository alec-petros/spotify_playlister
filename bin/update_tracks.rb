require_relative '../config/environment.rb'
Track.all.each do |track|
  spot_track = RSpotify::Track.find(track.spot_id)
  track.images = spot_track.album.images
  track.save
  puts "#{track.name} - #{track.images[0]["url"]}"
end
