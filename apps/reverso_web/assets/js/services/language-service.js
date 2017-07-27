export default {

  fetchLanguages(){
    let promise = Vue.http.get("/api/languages", {});

    return promise;
  },

  uploadLanguage(formData){
    let promise = Vue.http.post("/api/languages", formData);
  
    return promise;
  },
}