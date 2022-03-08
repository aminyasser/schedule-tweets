class TweetJob < ApplicationJob
  queue_as :default

  def perform(tweet)

    # if the tweet already published
    return if tweet.published?

    # if the published_at updated to future
    return if tweet.published_at > Time.current

    tweet.publish_to_twitter!
  end
end
