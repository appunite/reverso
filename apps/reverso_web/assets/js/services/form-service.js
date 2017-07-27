export default {
  formReady(project){
    if(project.project_name === "") return false;
    if(project.basic_language === "") return false;
    if(project.platforms.length < 1) return false;

    return true;
  },

  includesPlatform(array, platform_name){
      return _.includes(array, platform_name);
  },

  formReady(data){
    for (var key in data) {
       if (data.hasOwnProperty(key)) {
        if (data[key] == false || data[key] == null) return false;
      }
    }

    return true;
  }
}