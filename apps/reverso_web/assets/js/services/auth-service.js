import router from '../routes.js'

export default {
  login(context, creds, redirect) {
    context.$http.post("/api/login/", {
        params: creds
    }).then(
        (response) => {
            console.log("Logged in");
            console.log(response);
            console.log(context.$http.headers);

            localStorage.setItem("currentUser", creds);
            router.push(redirect)
        },
        (error) => {
            alert("Oops! Something went wrong!");
        }
    )
  },

  logout(context) {
    localStorage.removeItem('currentUser');
    router.push('/auth/login')
  },

  loggedIn() {
    return !!localStorage.getItem("currentUser");
  }
}