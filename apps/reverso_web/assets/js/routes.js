import Vue from 'vue'
import VueRouter from 'vue-router'



import logIn from './components/loggingIn/log-in.vue';
import lostPass from './components/loggingIn/lost-password.vue';

export default [
    { path: '/', component: logIn},
    { path: '/vue/lost-password', component: lostPass}
]