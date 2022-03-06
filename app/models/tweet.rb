class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :twitter_account

  validates :body , length: {minimum:1, maximum:280}
  validates :published_at , presence: :true

  after_initialize do
        self.published_at ||= 1.hour.from_now
  end  
  
  after_save_commit do
    if published_at_previously_changed?
      TweetJob.set(wait_until: published_at).perform_later(self)
    end
  end

  def published? 
      tweet_id?
  end 

  # To convert the time to AM/PM
  def getStringTime(time)
    show_time = time.hour
    min = time.min.to_s.rjust(2, "0")
    if show_time >= 12  
      if show_time == 12
          time = "12:#{min} PM"
      else time = "#{show_time - 12}:#{min} PM"
      end 
    else 
      if show_time == 0
          time = "12:#{min} AM"
      else time = "#{show_time}:#{min} AM" 
      end
    end
  end 
  

  def publish_to_twitter!
      tweet = twitter_account.client.update(body)
      update(tweet_id: tweet.id)
  end  
  
end  
