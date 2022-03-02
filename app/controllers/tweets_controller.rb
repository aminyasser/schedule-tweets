class TweetsController < ApplicationController
    before_action :authenticate_user! 

    def index
        current_user.tweets
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


    private 

    def tweet_params 
        params.require(:tweet).permit(:twitter_account_id , :body , :published_at)
    end   
end    