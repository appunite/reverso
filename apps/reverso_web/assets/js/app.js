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
import VueRouter from 'vue-router'

import VueResource from 'vue-resource'
import Routes from './routes'
import Main from "./main"

import ElementUI from 'element-ui'
//import 'element-ui/lib/theme-default/index.css'

Vue.use(VueRouter);
Vue.use(VueResource);
Vue.use(ElementUI)

const router = new VueRouter({
    routes: Routes
});

const app = new Vue({
  el: '#app',
  router,
  render: h => h(Main)
});


export {app}


// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
