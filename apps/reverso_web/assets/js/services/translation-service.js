export default {

fetchTranslation(project_id, language_id){
  let promise = Vue.http.get(
    `/api/projects/${project_id}/languages/${language_id}`, {});

  return promise;
},

createTerm(project_id, language_id, term){
  let promise = Vue.http.post(
    `api/projects/${project_id}/languages/${language_id}`, term);

  return promise;
},

updateTerm(project_id, language_id, term){
  let promise = Vue.http.patch(
    `api/projects/${project.id}/languages/${language_id}/${term.id}`, term);

  return promise;
},

deleteTerm(project_id, language_id, term_id){
  let promise = Vue.http.delete(
    `api/projects/${project_id}/languages/${language_id}/${term_id}`, {});

  return promise;
},

}