export default {
  setProfile(profile) {
    localStorage.setItem("currentUser", JSON.stringify(profile));
  },
  getProfile() {
    return JSON.parse(localStorage.getItem("currentUser"));
  }
}


