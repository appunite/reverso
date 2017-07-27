export default {

  fetchLanguages(){
    let promise = Vue.http.get("/api/languages", {});

    return promise;
  },

  uploadLanguage(formData){
    console.log(formData);
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
}