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
        Platfrom: <strong> {{ listed_platforms }} </strong>
        Reference Language: <strong> {{ reference }} </strong>

      </div>

      <div class="translationSideBar__section2">

        <p class="translationSideBar__titleFull">Translation Version</p>
        
        <el-progress
          :class="translationSideBar__progress"
          :show-text="false"
          :percentage="progress"
          status="success">
        </el-progress>      
      
        Language: <strong> {{ language.language_name }} </strong>
        Translated Strings: <strong>{{ language.strings_count }} </strong>
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
          v-bind:language_id="language_id"
          v-bind:language_name="reference">
          <el-button class="white-btn">
            Export
          </el-button>
        </exportSettings>
        
        <uploadLanguage
          v-bind:platforms="platforms"
          v-bind:language_id="language_id"
          v-bind:language_name="language.language_name">
        </uploadLanguage>
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
import uploadLanguage from "../project_components/actions/upload-existing-language"

export default {
  name: "sidebar",

  components: {
    'exportSettings': exportSettings,
    'deleteLanguage': deleteLanguage,
    'uploadLanguage': uploadLanguage
  },

  data () {
    return {
      projectName: "",
      platforms: [],
      reference: null,

      language: {},
      progress: 0,

      showSidebar: false
    }
  },

  computed: {
    listed_platforms(){
      return projectService.platformsMapToArray(this.platforms).join(", ");
    },

    lastEdit(){
      if(this.language.last_edit_time){
        return projectService.convertedTime(this.language.last_edit_time, "DD.MM.YYYY");
      }
      
      return "Never";
    },

    lastExport(){
      if(this.language.last_export_time){
        return projectService.convertedTime(this.language.last_export_time, "DD.MM.YYYY");
      }

      return "Never";
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
      this.platforms = translationData.platforms;
      this.reference = translationData.basic_language;
      
      this.language = translationData.languages[0];
      
      // this.calculateProgress(this.language.strings_count,
      //  this.reference.strings_count);  

      this.$bus.$emit('platforms', this.platforms);
    }, 

    calculateProgress(numerator, denominator){
      this.progress = _.floor(numerator/denominator * 100);

    }
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
