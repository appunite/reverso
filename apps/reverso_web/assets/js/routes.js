import Vue from 'vue'
import VueRouter from 'vue-router'



import logIn from './components/loggingIn/log-in.vue';
import lostPass from './components/loggingIn/lost-password.vue';
<<<<<<< HEAD
//import signIn from './components/signIn/sign-in.vue';

export default [
    { path: '/', component: logIn},
    { path: '/lost-password', component: lostPass},
    //{ path: '/sign-in', component: signIn}
=======
import activeSession from './components/activeSession/activeSession.vue';

export default [
    { path: '/', component: logIn},
    { path: '/vue/session', component: activeSession},
    { path: '/vue/lost-password', component: lostPass}

>>>>>>> master
]