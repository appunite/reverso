export default {
  resendActivation(params) {
    let promise = Vue.http.post("api/activate/resend", params);
    return promise;
  }
}
