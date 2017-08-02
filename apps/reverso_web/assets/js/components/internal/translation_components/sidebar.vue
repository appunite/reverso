<template>
<div id="translation-sidebar" class="translationSideBar">

  <div v-if="!showSidebar">
    <div class="translationSideBar__shown">

      <div class="translationSideBar__header">
      
        <span>Project Details</span>
        
        <img src="/images/translation/sidebar/ic-hide-sidemenu.svg"
          @click="showSidebar = !showSidebar">
      
      </div>
      
      <div class="translationSideBar__section1">

        Project: <strong> {{ projectName }} </strong>
        Platfrom: <strong> {{ platformName }} </strong>
        Reference Language: <strong> {{ refLang }} </strong>

      </div>

      <div class="translationSideBar__section2">

        <p class="translationSideBar__titleFull">Translation Version</p>
        
        <el-progress
          :class="translationSideBar__progress"
          :show-text="false"
          :percentage="progress"
          status="success">
        </el-progress>      
      
        Language: <strong> {{ language }} </strong>
        Translated Strings: <strong>{{ translatedStringsNumerator }} </strong>
        Last Edit: <strong> {{ lastEdit }} </strong>
        Last Export: <strong> {{ lastExport }} </strong>

      </div>
        
      <deleteLanguage v-bind:language_id="language_id">
        <b>Delete Language Version</b>
      </deleteLanguage>

      <div class="translationSideBar__buttonsWrapper">
        <exportSettings        
        v-bind:project_id="project_id"
        v-bind:project_name="projectName"
        v-bind:language="refLang">
          <el-button class="white-btn">
            Export
          </el-button>
        </exportSettings>
        
        <el-button class="white-btn">Upload file</el-button>
      </div>
      
      <div class="translationSideBar__backToProjectListWrapp">
        <router-link to="/projects">
          <img src="/images/translation/sidebar/ic-back-blue.svg">
          Back to project list
        </router-link>
      </div>
    
    </div>
  </div>

  <div v-else>
    <div class="translationSideBar__hidden">
      <img src="/images/translation/sidebar/ic-show-sidemenu.svg"
      @click="showSidebar = !showSidebar">
    </div>
  </div>

</div>
</template>

<script>
import projectService from "../../../services/project-service.js"
import exportSettings from "../project_components/export-settings"
import deleteLanguage from "../project_components/actions/delete-language"

export default {
  name: "sidebar",

  components: {
    'exportSettings': exportSettings,
    'deleteLanguage': deleteLanguage
  },

  data () {
    return {
      projectName: "",
      platformName: "",
      refLang: "",

      language: "",
      translatedStringsNumerator: 1,
      translatedStringsDenominator: 1,
      lastEdit: "",
      lastExport: "",  

      showSidebar: false
    }
  },

  computed: {
    progress(){
      let fraction = this.translatedStringsNumerator / this.translatedStringsDenominator;
      return Math.floor(fraction * 100);
    },

    language_id(){
      return this.$route.params.language_id;
    },

    project_id(){
      return this.$route.params.project_id;
    }
  },

  methods: {
    assignSidebarData(translationData){
      this.projectName = translationData.project_name;
      this.assignPlatforms(translationData);
      this.refLang = translationData.basic_language;
      this.assignTranslationVersionInfo(translationData);
    }, 

    assignPlatforms(translationData){
      var platforms = "";
      platforms = projectService.platformsMapToArray(translationData.platforms).join(", ");
      this.platformName = platforms;
    },

    assignTranslationVersionInfo(translationData){
      let currentLang = translationData.languages[0];

      this.language = currentLang.language_name;
      this.translatedStringsNumerator = currentLang.strings_count;
      /* CHANGE IT */ this.translatedStringsDenominator = currentLang.strings_count + 1;
      this.assignLastEditTime(currentLang);
      this.assignLastExportTime(currentLang);
    },

    assignLastEditTime(languageData){
      this.lastEdit = (languageData.last_edit_time) ? 
        projectService.convertedTime(languageData.last_edit_time, "DD.MM.YYYY")
        : "Never";
    },

    assignLastExportTime(languageData){
      this.lastExport = (languageData.last_export_time) ?
        projectService.convertedTime(languageData.last_export_time, "DD.MM.YYYY")
          : "Never";
    },
  },

  mounted (){
    projectService.loadSidebarData(this.project_id, this.language_id).then(
      (response) => {
        this.assignSidebarData(response.data.data);
      },
      (error) => {
        alert("Error while loading sidebar data");        
      }
    );
  },

}
  
</script>
