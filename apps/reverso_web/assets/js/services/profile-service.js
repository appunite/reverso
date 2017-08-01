export default {
  registerUser(params) {
    let promise = Vue.http.post('/api/accounts', params);
    return promise;
  },
  activateInvitedUser(params) {
    let promise = Vue.http.post('/api/invitation/update', params);
    return promise;
  },  
  setProfile(profile) {
    localStorage.setItem("currentUser", JSON.stringify(profile));
  },
  getProfile() {
    return JSON.parse(localStorage.getItem("currentUser"));
  },
  editProfile(creds) {
    let promise = Vue.http.patch(`/api/accounts/${creds.user.id}`, creds);
    return promise;
  },
  changePassProfile(params) {
    let promise = Vue.http.post('/api/changepassword', params);
    return promise;
  }
}
