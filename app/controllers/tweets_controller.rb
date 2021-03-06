class TweetsController < ApplicationController
    before_action :authenticate_user! 
    before_action :set_tweet , only: [:edit, :update, :show, :destroy , :publish]

    def index
        @tweets = current_user.tweets.paginate(page: params[:page], per_page: 3).where( "published_at > ?", Time.current).order(:published_at)
    end   
    def published
        @published_tweets =  current_user.tweets.paginate(page: params[:page], per_page: 3).where( "published_at < ?", Time.current).order("published_at DESC")
    end 

    def publish
        @tweet.publish_to_twitter!
        @tweet.update(published_at: Time.current)
        redirect_to published_tweets_path , notice: "Tweet Posted Successfully"
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