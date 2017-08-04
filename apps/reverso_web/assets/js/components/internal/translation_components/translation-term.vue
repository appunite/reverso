<template>
<tr @mouseover="showBin=true"
@mouseleave="showBin=false">

  <th>
    <span>
      <el-input
      type="textarea"
      :autosize="true"
      placeholder="No Reference"
      v-model="term.basic.basic"
      @blur="updateOrCreateField(term.basic)">
      </el-input>
      </span>
    </span>
  </th>

  <th>
    <el-input
    type="textarea"
    :autosize="true"
    v-model="term.translation.translation"
    placeholder="No Translation"
    @blur="updateOrCreateField(term.translation)">
  </el-input>
  </th>

  <th>
    <el-input
    type="textarea"
    :autosize="true"
    v-model="term.description"
    placeholder="No comments added"
    @blur="updateOrCreateField(term.description)">
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
    updateOrCreateField(field){
      // if(field.text){
      //   if(field.id){
      //     this.updateField(field);
      //   }

      //   else {
      //     this.createField(field);
      //   }
      // }
    },

    updateField(field){
      translationService.updateField(this.project_id, this.language_id, field).then(
        (response) => {

        },

        (error) => {
          console.log(error);
        }
      );
    },

    createField(field){
      translationService.createField(this.project_id, this.language_id, field).then(
        (response) => {
          //add key so it doesn't get created again
        },

        (error) => {
          console.log(error);
        }
      );
    },
  },
}

</script>