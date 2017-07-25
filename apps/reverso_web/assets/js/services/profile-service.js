export default {
  setProfile(profile) {
    localStorage.setItem("currentUser", JSON.stringify(profile));
  },
  getProfile() {
    return JSON.parse(localStorage.getItem("currentUser"));
  },
  editProfile(creds) {
    let promise = Vue.http.patch(`/api/accounts/${creds.user.id}`, creds);
    return promise;
  }
}


