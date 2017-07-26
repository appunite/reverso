<template>  
  <div id="nav-panel">
  
    <el-menu theme="dark" :default-active="activeIndex" class="el-menu-demo" mode="horizontal">
      <router-link to="/projects"><img src="/images/logo-white.svg" class="reverso-logo"></router-link>
      <el-submenu index="2">
        <template slot="title">User</template>
        <el-menu-item index="2-1"><router-link to="/profile"><img src="/images/ic-account.svg">Account</router-link></el-menu-item>
        <el-menu-item index="2-2" @click="logout"><img src="/images/ic-logout.svg">Log out</el-menu-item>
      </el-submenu>
    </el-menu>

  </div>
</template>

<script>
import authService from "../../services/auth-service"

export default {
  name: "navPanel",
  
  methods: {
    logout() {
      authService.logout();
    }
  }
}
  
</script>
