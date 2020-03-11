require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");

import "bootstrap";
import { initMapbox } from '../plugins/init_mapbox';
import { smoothScroll } from '../plugins/init_scroll';

document.addEventListener('turbolinks:load', () => {
  smoothScroll();
  initMapbox();
  const messageChatroom = document.getElementById("message_content");

  if (messageChatroom) {
    messageChatroom.addEventListener('keydown', (e) => {
      if (e.keyCode === 13) {
        e.preventDefault();
        document.getElementById('new_message').submit();
      }
    });
  }

//   if (localStorage['scroll']) {
//     window.scroll({ top: localStorage['scroll'] })
//   }
//   window.addEventListener('scroll', () => {
//     localStorage['scroll'] = window.scrollY;
// // console.log(localStorage['scroll'])
// console.log(window.scrollY)
//   });



}); // End Torbolink

