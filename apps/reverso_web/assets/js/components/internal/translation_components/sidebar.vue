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
<style lang="scss">
.translationSideBar {
  $shownSidebarWidth: 250px;
  $hiddenSidebarWidth: 50px;
  $leftMargin: 0.05*$shownSidebarWidth;
  $buttonWidth: 50px;

  $text-grey: #5E5F60;
  $border-gray: #EBEBF1;
  $label-gray: #969AA7;
  $purple: #5861E6;

  & {
    height: calc(100vh - 60px);
    background: #ffffff;
    border-right: 1px solid $border-gray;

    font-size: small;
    color: $text-grey;
  }

  &__shown {
    width: $shownSidebarWidth;
  }

  &__hidden {
    width: $hiddenSidebarWidth;
  }

  &__title {
    display: inline-block;
    margin: 18px 0 0 $leftMargin;
    width: 140px;    
    text-transform: uppercase;
    color: $label-gray;
    font-size: small;    
  }

  &__showHideButton {
    width: $buttonWidth;
    height: 32px;
    margin-top: 7px;

    text-align: center;
    background: transparent;
    border: 0;
    float: right;
    box-shadow: none;
  }

  &__showHideButton:focus {
    outline: 0;
    -webkit-box-shadow: none;
    box-shadow: none;
  }

  &__line {
    color: $text-grey;
    border-color: $border-gray;
    width: 0.9 * $shownSidebarWidth;
    clear: both;
    margin: 15px auto;
  }

  &__fullLine {
    color: $text-grey;
    border-color: $border-gray;
    width: 100%;
    clear: both;
    margin: 30px auto;
  }

  p {
    margin-left: $leftMargin;
  }

  &__infos {
    margin-bottom: 5px;
    p {
      margin-bottom: 0px;
    }
  }

  &__titleFull {
    display: block;
    width: $shownSidebarWidth;    
    text-transform: uppercase;
    color: $label-gray;
    font-size: small;    
  }

  .el-progress-bar {
    display: block;
    margin: 10px auto 15px auto;
    width: 90%;
  }

  .el-progress-bar__innerText {
    display: none;
  }

  &__date {
    color: $purple;
  }

  &__uploadButton {
    &, &:link, &:visited, &:hover, &:active { 
      font-size: 11px;
      font-weight: 400;
      text-transform: uppercase;
      text-decoration: none;
      color: $purple;
      cursor: pointer;

      display: inline-block;
      padding: 5px 5px 2px 5px;
      margin: 14px 6px 0 7px;  
    }  
  }

  &__filesSupported {
    font-size: 11px;
    font-style: italic;
    color: $label-gray;
    margin: 0 $leftMargin;    
  }

  &__backToProjectListWrapp {
    display: block;
    text-align: center;
    margin-top: 20px;
  }

  &__backToProjectList {
    &, &:link, &:visited, &:hover, &:active {
      text-decoration: none;
      text-transform: uppercase;
      font-size: 10px;
      font-weight: 700;
      color: $purple;
    }
  }

}
</style>
