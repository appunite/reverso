export default {

  fetchLanguages(){
    let promise = Vue.http.get("/api/languages", {});

    return promise;
  },

  uploadLanguageToProject(formData){
    var data = new FormData();

    data.append("project_id", formData.project_id);
    data.append("language_name", formData.language_name);
    data.append("language_file", formData.language_file);

    formData.platforms.forEach((plat, index) => {
      data.append(`platforms[${index}]`, plat);
    });

    let promise = Vue.http.post("/api/languages", data);
  
    return promise;
  },

  uploadFileToExistingLanguage(lang_id, lang_file, platforms){
    var data = new FormData();

    data.append("language_file", lang_file);
    platforms.forEach((plat, index) => {
      data.append(`platforms[${index}]`, plat);
    });

    let promise = Vue.http.patch(`/api/languages/${lang_id}`, data);
  
    return promise;
  },

  deleteLanguageFromProject(lang_id){
    let promise = Vue.http.delete(`/api/languages/${lang_id}`, {});
  
    return promise;
  }
}