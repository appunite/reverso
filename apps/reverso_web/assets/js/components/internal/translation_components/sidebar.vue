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
			<el-progress :class="translationSideBar__progress" :text-inside="true" :percentage="56" status="success"></el-progress>			
			<div class="translationSideBar__infos">
				<p>Language: <b>{{ language }}</b></p>
				<p>Translated Strings: <b>{{ translatedStrings }}</b></p>
				<p>Last Edit: <b class="translationSideBar__date">{{ lastEdit }}</b></p>
				<p>Last Export: <b>{{ lastExport }}</b></p>				
			</div>
			<a class="translationSideBar__uploadButton">
				<img src="/images/translation/sidebar/ic-upload.svg">Upload File
			</a>
			<div class="translationSideBar__filesSupported">csv, xls, xliff, xml files supported</div>
			<hr class="translationSideBar__line">
			<a class="translationSideBar__deleteLang">
				Delete Language Version
			</a>
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

export default {
	name: "sidebar",

	data () {
		return {
			projectName: "KingsChat",
			platformName: "Android",
			refLang: "English",

			language: "French",
			translatedStrings: "124/320",
			lastEdit: "07.27.2017",
			lastExport: "Never",	

      showSidebar: false
		}
	},

	computed: {
    language_id(){
      return this.$route.params.language_id;
    },

    project_id(){
      return this.$route.params.project_id;
    }
  },

	mounted (){
		//project show request
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

	&__deleteLang {
		&, &:link, &:visited, &:hover, &:active {
			display: inline-block;
			margin: 6px 0 6px 16px;

			font-size: 11px;
			font-weight: 500;
			text-decoration: none;
			text-transform: uppercase;
			color: #FF2B4E;
		}
	}

}
</style>
