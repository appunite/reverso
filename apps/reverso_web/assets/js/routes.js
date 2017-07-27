import VueRouter from 'vue-router'
Vue.use(VueRouter);

import authService from "./services/auth-service.js";

import loginPanel from './components/external/login/login-panel.vue';
import loginBox from './components/external/login/login_components/login-box.vue';
import lostPass from './components/external/login/login_components/lost-password.vue';
import resetPassConfirmInfo from './components/external/login/login_components/reset-pass-confirm-info.vue';
import resetPassword from './components/external/login/login_components/reset-password.vue';

import accountActivated from './components/external/account_actions/account-activated.vue'

import registrationPanel from './components/external/registration/registration-panel.vue';
import signUp from './components/external/registration/registration_components/sign-up.vue';
import newUserBox from './components/external/registration/registration_components/new-user-box.vue';

import sessionPanel from './components/internal/session-panel.vue';
import projectList from './components/internal/project_components/project-list.vue';
import seeProfile from './components/internal/user_components/see-profile.vue';
import editProfile from './components/internal/user_components/edit-profile.vue';
import changePass from './components/internal/user_components/change-pass.vue';

import translationPanel from './components/internal/translation-panel.vue';

const router = new VueRouter({
    routes: [
      { path: '/', 
        component: loginPanel,
        redirect: '/log-in',
        children: [
          { path: '/log-in', component: loginBox },
          { path: '/lost-password', component: lostPass },
          { path: '/account-activated', component: accountActivated },
          { path: '/reset-pass-confirm-info', component: resetPassConfirmInfo },
          { path: '/reset-password', component: resetPassword }
        ]
      },
      { path: '/registration', 
        component: registrationPanel,
        redirect: '/sign-up',        
        children: [
          { path: '/sign-up', component: signUp },
          { path: '/new-user-box', component: newUserBox }
        ]
      },
      { path: '/session',
        component: sessionPanel,
        meta: { requiresAuth: true },
        children: [
          { path: '/projects', component: projectList },
          { path: '/profile', component: seeProfile },
          { path: '/edit-profile', component: editProfile },
          { path: '/edit-pass', component: changePass },

          { path: '/translation/:project_id/:language_id',
          name: 'translation',
          component: translationPanel}

        ]
      }
    ]
});

router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    if (!authService.loggedIn()) {
      authService.logout();
      next({
        path: '/log-in'
      })
    } else {
      next();
    }
  } else {
    if (authService.loggedIn()) {
      next({
        path: '/projects'
      })
    } else {
      next();
    }
  }
})

export default router

