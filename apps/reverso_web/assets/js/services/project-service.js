export default {
    process(resp){
      return JSON.parse(resp.bodyText).data;
    },

    formReady(project){
        if(project.project_name === "") return false;
        if(project.basic_language === "") return false;
        //if(project.platforms.length < 1) return false;

        return true;
    },

     
    setProgressValues(translations, basic_lang){
      var language_count = translations.length;

      var reference_idx = _.findIndex(translations, ['language_name', basic_lang]);
      
      if(reference_idx > 0){
        var reference_str_count = translations[reference_idx].count;
      }

      var progress_percentage = calculateProgress(translations, language_count, reference_str_count);

      return [language_count, reference_str_count, progress_percentage];
    },

    calculateProgress(translations, language_count, reference_str_count){
      var numerator = _.sumBy(translations, 'count');
      var denominator = language_count * reference_str_count;
    
      var progress_percentage = _.floor(100 * numerator / denominator);

      return progress_percentage;
    },

    deleteProject(project){
      let promise = Vue.http.delete(`/api/projects/${project.id}`, {});

      return promise;
    }

}