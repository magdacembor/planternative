const smoothScroll = () => {
  const chatroom = document.querySelector(".chatroom");
  if (chatroom) {
    console.log(chatroom.scrollHeight);
    chatroom.scroll({
      top: chatroom.scrollHeight
    });
  }
};

export { smoothScroll };
