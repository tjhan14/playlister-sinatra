class Song < ActiveRecord::Base 
    belongs_to :artist
    has_many :song_genres  
    has_many :genres, through: :song_genres  
    
    def slug
        array = self.name.split
        new_array = array.map {|word| word.downcase}
        new_array.join("-")
    end

    def self.find_by_slug(slug)
        self.all.find{ |artist| artist.slug == slug}
    end

end




# artist -< song -< song_genre >- genre


