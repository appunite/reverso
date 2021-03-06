// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

import VueResource from 'vue-resource'
import router from './routes'

import ElementUI from 'element-ui'
import VueChatScroll from 'vue-chat-scroll'

import Main from './main'

import authService from "./services/auth-service"

const bus = new Vue();

Vue.use(VueResource);
Vue.use(ElementUI);
Vue.use(VueChatScroll);

Object.defineProperty(Vue.prototype, '$bus', {
  get() {
    return this.$root.bus;
  }
});

const app = new Vue({
  data: {
    bus: bus
  },
  router,
  render: h => h(Main)
});

Vue.http.interceptors.push((request, next) => {
  if (sessionStorage.getItem('auth_token')) {
    request.headers.set('authorization', sessionStorage.getItem('auth_token'))
  }

  next();
})

app.$mount("#app");

export {app}


// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"