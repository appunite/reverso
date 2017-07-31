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
      <a class="translationSideBar__deleteLang" href="#">
        Delete Language Version
      </a>
      <div class="translationSideBar__bakcToProjectListWrapp">
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

export default {
  name: "sidebar",

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

      this.platformName = "";
      for(let i = 0; i < translationData.platforms.length; i++)
      {
        if(i != 0)
          this.platformName += ", ";
        this.platformName += translationData.platforms[i];
      }

      this.refLang = translationData.basic_language;

      let currentLang = translationData.languages[0];
      this.language = currentLang.language_name;
      this.translatedStringsNumerator = currentLang.strings_count;
      /* CHANGE IT */this.translatedStringsDenominator = currentLang.strings_count + 1;
      this.lastEdit = (currentLang.last_edit_time) ? currentLang.last_edit_time : "Never";
      /* CHANGE IT */this.lastExport = "Never"; 
    } 
  }
}
  
</script>
