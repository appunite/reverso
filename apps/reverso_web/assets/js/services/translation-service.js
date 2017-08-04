export default {

fetchTranslation(project_id, language_id, filter){
  let promise = Vue.http.get(
    `/api/projects/${project_id}/languages/${language_id}`, filter);

  return promise;
},

createField(project_id, language_id, field){
  let promise = Vue.http.post(
    `api/projects/${project_id}/languages/${language_id}`, field);

  return promise;
},

updateField(project_id, language_id, field){
  let promise = Vue.http.patch(
    `api/projects/${project_id}/languages/${language_id}/${field.id}`, field);

  return promise;
}

}