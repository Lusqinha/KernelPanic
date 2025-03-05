class AddSpotifyTrackUrlToPost < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :spotify_track_url, :string
  end
end