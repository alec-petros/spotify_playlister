require_relative '../config/environment.rb'
Track.all.each do |track|
  spot_track = RSpotify::Track.find(track.spot_id)
  track.acousticness = spot_track.audio_features.acousticness
  track.danceability = spot_track.audio_features.danceability
  track.energy = spot_track.audio_features.energy
  track.instrumentalness = spot_track.audio_features.instrumentalness
  track.liveness = spot_track.audio_features.liveness
  track.speechiness = spot_track.audio_features.speechiness
  track.tempo = spot_track.audio_features.tempo
  track.valence = spot_track.audio_features.valence
  track.time_signature = spot_track.audio_features.time_signature
  track.key = spot_track.audio_features.key
  track.mode = spot_track.audio_features.mode
  track.save
  puts "#{track.name} - #{track.danceability}"
end
