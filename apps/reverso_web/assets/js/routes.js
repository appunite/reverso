import loginPanel from './components/panels/login-panel.vue';
import sessionPanel from './components/panels/session-panel.vue';
// import registrationPanel from './components/panels/registration-panel.vue';


import loginBox from './components/login_components/login-box.vue';
import lostPass from './components/login_components/lost-password.vue';

import projectList from './components/project_components/project-list.vue';


export default [
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
		children: [
			{ path: '/projects', component: projectList }
			// lista projektow,
			// tłumaczenie,
			// użytkownik
		]
	}//,
	// { path: '/register', component: registrationPanel	}
]