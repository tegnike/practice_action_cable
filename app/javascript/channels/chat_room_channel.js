import consumer from "./consumer"

const appChatRoom = consumer.subscriptions.create("ChatRoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  // chat_room_channel.rbから送られてきたhtmlテンプレートを受け取り、画面を書き換え
  received(data) {
    var chat_message = data['chat_message'];
    var send_user_id = data['send_user_id'];
    debugger
    if (parseInt($('#hidden_current_user_id').text()) !== send_user_id) {
      if (!$('#hidden_profile_image_url').text()) {
        var image = `<div class="chat-message__partner-default-img"></div>`
      } else {
        var image = `<img class="chat-message__partner-img" src="${$('#hidden_profile_image_url').text()}">`
      }
      var content_message = `
      <div class="chat-message">
        <div class="chat-message__partner">
          ${image}
          <div class="chat-message__content">
            ${chat_message}
          </div>
        </div>
      `
    } else {
      var content_message = `
      <div class="chat-message">
        <div class="chat-message__current-user">
          <div class="chat-message__content main-color-bg">
            ${chat_message}
          </div>
        </div>
      </div>
      `
    }
    const chatMessages = document.getElementById('chat-messages');
    chatMessages.insertAdjacentHTML('beforeend', content_message);
  },

  // chat_room_channel.rbのspeakアクションにmessageとroom_idを送信
  speak: function(chat_message, chat_room_id) {
    return this.perform('speak', { chat_message: chat_message, chat_room_id: chat_room_id });
  }
});

if(/chat_rooms/.test(location.pathname)) {
  $(document).on("keydown", ".chat-room__message-form_textarea", function(e) {
    if (e.key === "Enter") {
      const chat_room_id = $('textarea').data('chat_room_id')
      appChatRoom.speak(e.target.value, chat_room_id);
      e.target.value = '';
      e.preventDefault();
    }
  })
}
