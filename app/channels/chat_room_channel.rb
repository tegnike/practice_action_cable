class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # チャットメッセージをchat_room_channel.jsのspeakから受け取り、
  # chat_room_channel.jsのreceiveに送り返す
  # 
  # current_userはapp/channels/application_cable/connection.rbで定義
  def speak(data)
    ChatMessage.create!(
      content: data['chat_message'],
      user_id: current_user.id,
      chat_room_id: data['chat_room_id']
    )
  end
end
