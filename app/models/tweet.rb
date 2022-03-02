class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :twitter_account

  validates :body , length: {minimum:1, maximum:280}
  validates :published_at , presence: :true

  after_initialize do
        self.published_at ||= 1.hour.from_now
  end  

  def published? 
      tweet_id?
  end 
  def getStringTime(time)
    show_time = time.hour
    if show_time >= 12  
      if show_time == 12
          time = "12:#{time.min} PM"
      else time = "#{show_time - 12}:#{time.minute}PM"
      end 
    else 
      if show_time == 0
          time = "12:#{time.min} AM"
      else time = "#{show_time}:#{time.min} AM" 
    end
  end
  end 
  
  
end  
