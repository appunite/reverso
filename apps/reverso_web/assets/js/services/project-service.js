export default {
    process(resp){
      return JSON.parse(resp.bodyText).data;
    },

    formReady(project){
        if(project.project_name === "") return false;
        if(project.basic_language === "") return false;
        if(project.platforms.length < 1) return false;

        return true;
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
    }

}