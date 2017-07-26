export default {

  fetchLanguages(){
    let promise = Vue.http.get("/api/languages", {});

    return promise;
  }

}