export default {

  fetchTranslation(project_id, language_id){
    let promise = Vue.http.get(`/api/projects/${project_id}/languages/${language_id}`, {});

    return promise;
  },
}