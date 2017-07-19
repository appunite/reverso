<template>	
	<div id="nav-panel">
	
		<el-menu theme="dark" :default-active="activeIndex" class="el-menu-demo" mode="horizontal" @select="handleSelect">
		  <el-menu-item index="1"><img src="/images/logo-white.svg"></el-menu-item>
		  <el-submenu index="2">
		    <template slot="title">User</template>
		    <el-menu-item index="2-1"><img src="/images/ic-account.svg">Account</el-menu-item>
		    <el-menu-item index="2-2" style="color: red;" @click="logout"><img src="/images/ic-logout.svg">Log out</el-menu-item>
		  </el-submenu>
		</el-menu>

	</div>
</template>

<script>
import authService from "../../../services/auth-service"

export default {
	name: "navPanel",
	data () {
		return {
		}
	},
	methods: {
		logout() {
			authService.logout(this);
		}
	}
}
	
</script>

<style scoped>
/*	#menu {
		background:  #040a42;
		padding: 18px 16px;	
	}

	#menu ul {
		list-style-type: none;
		display: inline;
	}

	#menu li {
		float: left;
		color: white;
		background:  #040a42;
	}

	#menu button {
		border: 0px;
		color: white;
		background:  #040a42;
	}

	.dropdown-menu {
		border-radius: 0 !important; 
	}

	.dropdown-menu li {
		background: white !important;
		color: black;
		padding: 10px;
	}*/

</style>