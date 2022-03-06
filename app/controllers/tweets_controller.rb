class TweetsController < ApplicationController
    before_action :authenticate_user! 
    before_action :set_tweet , only: [:edit, :update, :show, :destroy]

    def index
        @tweets = current_user.tweets.paginate(page: params[:page], per_page: 2).where( "published_at > ?", Time.current).order(:published_at)
    end   
    def published
        @published_tweets =  current_user.tweets.paginate(page: params[:page], per_page: 2).where( "published_at < ?", Time.current)
    end 
    
    def new
        @tweet = Tweet.new
    end    

    def create
        @tweet  = current_user.tweets.new(tweet_params)
        if @tweet.save 
            redirect_to tweets_path , notice: "Tweet scheduled Successfully"
        else
            render :new
        end
    end
    
    def edit 
    end    

    def update
        if @tweet.update(tweet_params)
            redirect_to tweets_path , notice: "Tweet updated Successfully"
        end    
    end
    
    def destroy
        @tweet.destroy
        redirect_to tweets_path , notice: "Tweet destroyed Successfully"
    end    


    private 

    def tweet_params 
        params.require(:tweet).permit(:twitter_account_id , :body , :published_at)
    end  
    
    def set_tweet
        @tweet = current_user.tweets.find(params[:id])
    end   
end    