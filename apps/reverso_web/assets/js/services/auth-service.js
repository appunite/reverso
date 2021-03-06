import router from '../routes.js'
import profileService from "../services/profile-service"

export default {
  logout() {
    Vue.http.delete('/api/logout', {}).then(
      (response) => {
        localStorage.removeItem('currentUser');
        sessionStorage.removeItem('auth_token');
        router.push('/log-in');
      },
      (error) =>{
        if(error.status != 401)
        { alert("Logout: Oops! Something went wrong!"); }
      }
    )
  },

  login(creds) {
    let promise = Vue.http.post("/api/login", {
        params: creds
    })

    return promise;
  },

  onLoginSuccess(response) {
      let token = response.data.user_token;

      let tempProfile = response.data;
      let profile = {"email" : tempProfile.email, "id": tempProfile.id, "name": tempProfile.name};

      profileService.setProfile(profile);
      sessionStorage.setItem("auth_token", token);

      router.push("/projects");
  },

  loggedIn() {
    return !!sessionStorage.getItem("auth_token");
  }
}
