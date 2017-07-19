import router from '../routes.js'
import profileService from "../services/profile-service"

export default {
//     login(context, creds, redirect) {
//         context.$http.post("/api/login", {
//         params: creds
//     }).then(
//         (response) => {
//             localStorage.setItem("currentUser", JSON.stringify(response));
//         },
//         (error) => {
//             alert("Oops! Something went wrong!");
//         }
//     );
// },
  logout(context) {
    localStorage.removeItem('currentUser');
    sessionStorage.removeItem('auth_token');
    router.push('/log-in')
  },

  login(creds) {
    let promise = Vue.http.post("/api/login", {
        params: creds
    })

    return promise;
  },

  onLoginSuccess(response) {
      let token = response.headers.map.authorization[0];
      let profile = response.data;

      profileService.setProfile(profile);
      sessionStorage.setItem("auth_token", token);

      router.push("/session");
  },

  loggedIn() {
    return !!sessionStorage.getItem("auth_token");
  }
}