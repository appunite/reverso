export default {
    process(resp){
      return JSON.parse(resp.bodyText).data;
    },

    fetchProjects(){
      let promise = Vue.http.get("/api/projects", {});

      return promise;
    },

    createProject(project){
      let promise = Vue.http.post("api/projects", project);

      return promise;
    },

    updateProject(project){
      let promise = Vue.http.patch(`api/projects/${project.id}`, project);

      return promise;
    },

    deleteProject(project){
      let promise = Vue.http.delete(`/api/projects/${project.id}`, {});

      return promise;
    },

    exportProject(project_id){
      let promise = Vue.http.get(`/api/projects/${project_id}/export`, {});
     
      return promise;
    },

    exportLanguage(project_id, language_id){
      let promise = Vue.http.get(`/api/projects/${project_id}/languages/${language_id}`, {});
      
      return promise;
    }
}