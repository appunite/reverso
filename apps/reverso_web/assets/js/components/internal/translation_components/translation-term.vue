<template>
<tr @mouseover="showBin=true"
@mouseleave="showBin=false">

  <th>
    <span>
      <el-input
      type="textarea"
      :autosize="true"
      placeholder="No Reference"
      v-model="term.basic"
      @blur="updateTerm(term)">
      </el-input>

      <img src="/images/ic-delete.svg"
      v-show="showBin" @click="deleteTerm(term)">
    </span>
  </th>

  <th>
    <el-input
    type="textarea"
    :autosize="true"
    v-model="term.translation"
    placeholder="No Translation"
    @blur="updateTerm(term)">
  </el-input>
  </th>

  <th>
    <el-input
    type="textarea"
    :autosize="true"
    v-model="term.description"
    placeholder="No comments added"
    @blur="updateTerm(term)">
  </el-input>
  </th>

</tr>
</template>

<script>
  import translationService from '../../../services/translation-service.js'

  export default {
  name: 'translationTerm',

  props: [
  'term'
  ],

  data(){
    return {
      showBin: false
    }
  },

  computed: {
    project_id(){
      return this.$route.params.project_id;
    },

    language_id(){
      return this.$route.params.language_id;
    }
  },

  methods: {
    updateTerm(term){
      if(term.id){
        translationService.createTerm(this.project_id, this.language_id, term).then(
          (response) => {

          },

          (error) => {
            console.log(error);
          }
          );
      }
      else {
        translationService.updateTerm(this.project_id, this.language_id, term).then(
          (response) => {

          },

          (error) => {
            console.log(error);
          }
          );
      }
    },

    deleteTerm(term){
      translationService.deleteTerm(this.project_id, this.language_id, term.id).then(
        (response) => {

        },

        (error) => {
          console.log(error);
        }
      );
    }
  }
}

</script>