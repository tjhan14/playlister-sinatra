class SongGenre < ActiveRecord::Base 
    belongs_to :song 
    belongs_to :genre 
end



# artist -< song -< song_genre >- genre