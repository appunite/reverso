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
      @blur="updateOrCreateTerm(term)">
      </el-input>
      <span class="delete-img-wrapper">
      <img src="/images/translation/ic-delete.svg"
      v-show="showBin" @click="deleteTerm(term)">
      </span>
    </span>
  </th>

  <th>
    <el-input
    type="textarea"
    :autosize="true"
    v-model="term.translation"
    placeholder="No Translation"
    @blur="updateOrCreateTerm(term)">
  </el-input>
  </th>

  <th>
    <el-input
    type="textarea"
    :autosize="true"
    v-model="term.description"
    placeholder="No comments added"
    @blur="updateOrCreateTerm(term)">
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
    updateOrCreateTerm(term){
      if(term.basic){
        if(term.id){
          this.updateTerm(term);
        }

        else {
          this.createTerm(term);
        }
      }
    },

    updateTerm(term){
      translationService.updateTerm(this.project_id, this.language_id, term).then(
        (response) => {

        },

        (error) => {
          console.log(error);
        }
      );
    },

    createTerm(term){
      translationService.createTerm(this.project_id, this.language_id, term).then(
        (response) => {
          //add key so it doesn't get created again
        },

        (error) => {
          console.log(error);
        }
      );
    },

    deleteTerm(term){
      if(term.id){
        translationService.deleteTerm(this.project_id, this.language_id, term.id).then(
          (response) => {
            console.log(response);
            this.$emit('term_deleted', term);
          },

          (error) => {
            console.log(error);
          }
        );
      }

      else {
        this.$emit('row_deleted', term);
      }
    }
  }
}

</script>