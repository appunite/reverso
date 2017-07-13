
import loginPanel from './components/panels/login-panel.vue';
import sessionPanel from './components/panels/session-panel.vue';
// import registrationPanel from './components/panels/registration-panel.vue';


import loginBox from './components/login_components/login-box.vue';
import lostPass from './components/login_components/lost-password.vue';

import projectList from './components/project_components/project-list.vue';

import seeProfile from './components/user_components/see-profile.vue';
import editProfile from './components/user_components/edit-profile.vue';
import changePass from './components/user_components/change-pass.vue';

export default [
	{ path: '/', 
		component: loginPanel,
		redirect: '/log-in',
		children: [
			{ path: '/log-in', component: loginBox },
			{ path: '/lost-password', component: lostPass },

			{ path: '/profile', component: seeProfile },
			{ path: '/edit-profile', component: editProfile },
			{ path: '/edit-pass', component: changePass },
		]
	},
	{ path: '/session',
		component: sessionPanel,
		children: [
			{ path: '/projects', component: projectList }
			// lista projektow,
			// tłumaczenie,
			// użytkownik
		]
	}//,
	// { path: '/register', component: registrationPanel }
]