class CommentsChannel < ApplicationCable::Channel

# this method is called whenever an user subcribes to the channel
  def subscribed
    stream_from "comments"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
