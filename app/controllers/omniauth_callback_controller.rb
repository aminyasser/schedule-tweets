class OmniauthCallbackController < ApplicationController
    def twitter 
        twitter_account = current_user.twitter_accounts.where(username: auth.info.nickname).first_or_initialize
        twitter_account.update(
            name: auth.info.name, 
            username: auth.info.nickname, 
            image: auth.info.image , 
            token: auth.credentials.token, 
            secret: auth.credentials.secret, 
        )
        
        redirect_to twitter_accounts_path , notice: "Account Connected Successfully"
    end    

    def auth 
        request.env['omniauth.auth']
    end    
end   