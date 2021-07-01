require 'rack-flash'

class SongsController < ApplicationController
    enable :sessions
    use Rack::Flash

    get '/songs' do
        @songs = Song.all 
        erb :'/songs/index'
    end

    get '/songs/new' do 
        erb :'songs/new'
    end

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/show'
    end

    post '/songs' do
        @song = Song.create(params[:song])

        # add artist
        # checking if the input artist exists in database
        if Artist.where("lower(name) = ?", params[:artist_name].downcase).first
            # an artist DOES exist
            @song.artist = Artist.where("lower(name) = ?", params[:artist_name].downcase).first
        else
            # an artist DOESN'T exist -> create new artist
            @song.artist = Artist.create(name: params[:artist_name])
        end

        # add genre
        params[:genres].each do |genre_id|
            @song.genres << Genre.find_by_id(genre_id)
        end

        @song.save

        flash[:message] = "Successfully created song."

        redirect "/songs/#{@song.slug}"
    end

    get '/songs/:slug/edit' do 
        @song = Song.find_by_slug(params[:slug])
        erb :'/songs/edit'        
    end

    # patch '/songs/:slug' do
    #     # @song = Song.find_by_slug(params[:slug])

    #     # @song.name = params[:song][name]

    #     # # update artist
    #     # if Artist.where("lower(name) = ?", params[:artist_name].downcase).first
    #     #     # an artist DOES exist
    #     #     @song.artist = Artist.where("lower(name) = ?", params[:artist_name].downcase).first
    #     # else
    #     #     # an artist DOESN'T exist -> create new artist
    #     #     @song.artist = Artist.create(name: params[:artist_name])
    #     # end

    #     # # update genres
    #     # params[:genres].each do |genre_id|
    #     #     @song.genres << Genre.find_by_id(genre_id)
    #     # end

    #     # @song.save

    #     # redirect "/song/#{@song.slug}"
    # end

end