import VueRouter from 'vue-router'
Vue.use(VueRouter);

import authService from "./services/auth-service.js";

import loginPanel from './components/external/login/login-panel.vue';
import loginBox from './components/external/login/login_components/login-box.vue';
import lostPass from './components/external/login/login_components/lost-password.vue';
import registrationPanel from './components/external/registration/registration-panel.vue';

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
					{ path: '/lost-password', component: lostPass }
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

					{ path: '/translation', component: translationPanel}
				]
			}//,
			// { path: '/register', component: registrationPanel }
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
      next()
    }
  } else {
    next()
  }
})

export default router

