import router from '../routes.js'
import profileService from "../services/profile-service"

export default {
  logout(context) {
    // context.$http.delete('/logout')
    // .success(function(response) {
      localStorage.removeItem('currentUser');
      sessionStorage.removeItem('auth_token');
      router.push('/log-in')
    // }) 
    // .error(function(errors) {
    //   alert("Oops! Something went wrong!");
    // });
  },

  login(creds) {
    let promise = Vue.http.post("/api/login", {
        params: creds
    })

    return promise;
  },

  onLoginSuccess(response) {
    console.log(response);
      debugger;
      let token = response.headers.map.Authorization[0];
      let profile = response.data;

      profileService.setProfile(profile);
      sessionStorage.setItem("auth_token", token);

      router.push("/session");
  },

  loggedIn() {
    return !!sessionStorage.getItem("auth_token");
  }
}