export default {
    process(resp){
      return JSON.parse(resp.bodyText).data;
    },

    formReady(project){
        if(project.project_name === "") return false;
        if(project.basic_language === "") return false;
        if(project.platforms.length < 1) return false;

        return true;
    }
}