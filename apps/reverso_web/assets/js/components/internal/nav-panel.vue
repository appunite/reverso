<template>	
	<div id="nav-panel">
	
		<el-menu theme="dark" :default-active="activeIndex" class="el-menu-demo" mode="horizontal" @select="handleSelect">
		  <router-link to="/projects"><img src="/images/logo-white.svg" style="margin: 16px 10px;n"></router-link>
		  <el-submenu index="2">
		    <template slot="title">User</template>
		    <el-menu-item index="2-1" @click="account"><img src="/images/ic-account.svg">Account</el-menu-item>
		    <el-menu-item index="2-2" style="color: #fe3c5b;" @click="logout"><img src="/images/ic-logout.svg">Log out</el-menu-item>
		  </el-submenu>
		</el-menu>

	</div>
</template>

<script>
import authService from "../../services/auth-service"
import router from "../../../routes.js"; // for router.push()

export default {
	name: "navPanel",
	data () {
		return {
		}
	},
	methods: {
		account() {
			router.push("/profile");
		},		
		logout() {
			authService.logout();
		}
	}
}
	
</script>