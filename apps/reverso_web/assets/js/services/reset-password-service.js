export default {
  sendResetEmailProfile(params) {
    let promise = Vue.http.post("/api/lostpassword", params);
    return promise;
  },
  resetPassword(params) {
    let promise = Vue.http.post("api/resetpassword", params);
    return promise;
  }
}