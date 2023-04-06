class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  get '/' do
    { message: "Hello world" }.to_json
  end

  get '/games' do
    
    # games = Game.all.map do |game|
    #   {game.title => {
    #     genre: game.genre,
    #     platform: game.platform,
    #     price: game.price
    #   }}
    # end
    # games.to_json

    Game.all.order(:title).limit(10).to_json
  end

  get '/games/:id' do
    Game.find(params[:id]).to_json(
      only:[:id, :title, :genre, :price],
      include:
        {reviews: {only: [:comment, :score],
      include:
        {user: {only: [:name]}
      }}
    })
    # Game.find_by_id(params[:id]).to_json
    # Game.all.where(id: params[:id]).to_json
  end


end
