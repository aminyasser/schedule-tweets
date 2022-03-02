class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :twitter_account

  validates :body , length: {minimum:1, maximum:280}
  validates :published_at , presence: :true

  after_initialize do
        self.published_at ||= 1.hour.from_now
  end  
end
