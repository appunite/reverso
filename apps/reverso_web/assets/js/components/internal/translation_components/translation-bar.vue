<template>

  <div class="top-table-panel">

    <span>  
    <el-button type="text" class="add_sth_btn" @click="addTerm">
      <img src="/images/ic-add.svg">Add new term
    </el-button>
    </span>

    <span class="top-table-panel__radio-buttons">
      <strong>View:</strong>

      <el-radio-group fill="#5f69ef" v-model="filter.platform">
        <el-radio label="Translating">Translating</el-radio>
      </el-radio-group>
    </span>

    <span>
      <input placeholder="Search..." class="search-input" v-model="filter.search">
    </span>
    
    <span class="top-table-panel__dropdowns">  

      <el-dropdown>
        <span class="el-dropdown-link">
          <img src="/images/translation/ic-filter.svg">
        </span>

        <el-dropdown-menu slot="dropdown">  
          <el-dropdown-item v-for="show_type in show_types">
            <input type="radio" name="show" :value="show_type" v-model="filter.show">
            {{ show_type }}
          </el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>      

      <el-dropdown>
        <span class="el-dropdown-link">
          <img src="/images/translation/ic-sort.svg">
        </span>

        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item v-for="sort_type in sort_types">
            <input type="radio" name="sort" :value="sort_type" v-model="filter.sort">
            {{ sort_type }}
          </el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>

    </span>

  </div>  

</template>

<script>

export default {
  name: 'translationBar',

  props: [
    'platforms'
  ],

  data(){
    return {
      show_types: ["All", "Empty"],
      sort_types: ["Alphabetically", "Recently Updated", "Recently Added"],

      filter: {
        platform: "Translating",
        search: "",
        show: "All",
        sort: "Alphabetically"
      }
    }
  },

  methods: {
    addTerm(){
      this.$emit('addTerm')
    }
  }
}  
</script>