<template>
<div id="translation-sidebar" class="translationSideBar">

  <div v-if="!showSidebar">
    <div class="translationSideBar__shown">
      <p class="translationSideBar__title">Project Details</p>
      
      <button class="translationSideBar__showHideButton" @click="showSidebar = !showSidebar">
        <img src="/images/translation/sidebar/ic-hide-sidemenu.svg">
      </button>
      
      <hr class="translationSideBar__line">
      
      <div class="translationSideBar__infos">
        <p>Project: <b>{{ projectName }}</b></p>
        <p>Platform: <b>{{ platformName }}</b></p>
        <p>Reference Language: <b>{{ refLang }}</b></p>
      </div>

      <hr class="translationSideBar__fullLine">
      
      <p class="translationSideBar__titleFull">Translation Version</p>
      
      <el-progress :class="translationSideBar__progress" :text-inside="true" :percentage="progress" status="success"></el-progress>      
      
      <div class="translationSideBar__infos">
        <p>Language: <b>{{ language }}</b></p>
        <p>Translated Strings: <b>{{ translatedStringsNumerator }}/{{ translatedStringsDenominator }}</b></p>
        <p>Last Edit: <b class="translationSideBar__date">{{ lastEdit }}</b></p>
        <p>Last Export: <b>{{ lastExport }}</b></p>        
      </div>
      
      <a class="translationSideBar__uploadButton" href="#">
        <img src="/images/translation/sidebar/ic-upload.svg">Upload File
      </a>
      
      <div class="translationSideBar__filesSupported">csv, xls, xliff, xml files supported</div>
      <hr class="translationSideBar__line">
      
      <deleteProject>
        <b>Delete Language Version</b>
      </deleteProject>

      <div class="translationSideBar__buttonsWrapper">
        <exportSettings        
        v-bind:project_id="project_id"
        v-bind:project_name="projectName"
        v-bind:language="refLang">
          <el-button class="white-btn">
          Export
          </el-button>
        </exportSettings>
        
        <el-button type="primary" class="primary-btn">Save</el-button>
      </div>
      
      <div class="translationSideBar__backToProjectListWrapp">
        <router-link class="translationSideBar__backToProjectList" to="/projects">
          <img src="/images/translation/sidebar/ic-back-blue.svg"> Back to project list
        </router-link>
      </div>
    
    </div>
  </div>

  <div v-else>
    <div class="translationSideBar__hidden">
      <button class="translationSideBar__showHideButton" @click="showSidebar = !showSidebar">
        <img src="/images/translation/sidebar/ic-show-sidemenu.svg">
      </button>
    </div>
  </div>

</div>
</template>

<script>
import projectService from "../../../services/project-service.js"
import exportSettings from "../project_components/export-settings"
import deleteProject from "../project_components/actions/delete-project"

export default {
  name: "sidebar",

  components: {
    'exportSettings': exportSettings,
    'deleteProject': deleteProject
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
      /* CHANGE IT */this.translatedStringsDenominator = currentLang.strings_count + 1;
      this.assignLastEditTime(currentLang);
      this.assignLastExportTime(currentLang);
    },

    assignLastEditTime(languageData){
      this.lastEdit = (languageData.last_edit_time) ? languageData.last_edit_time : "Never";
    },

    assignLastExportTime(languageData){
      /* CHANGE IT */
      this.lastExport = (languageData.last_export_time) ? languageData.last_export_time : "Never";
    }


  }

}
  
</script>
