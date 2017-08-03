<template>

  <div class="top-table-panel-translation">
    <span>  
    <el-button type="text" class="add_sth_btn" @click="addTerm">
      <icon
      imageName='add'
      color='#5F69EF'>
      </icon>
      Add new term
    </el-button>
    </span>

    <span class="top-table-panel-translation__radio-buttons">
      <strong>View:</strong>

      <el-radio-group fill="#5f69ef" v-model="filter.platform">
        <el-radio label="Translating">Translating</el-radio>
      </el-radio-group>
    </span>
    
    <span class="top-table-panel-translation__filters">  
      <input placeholder="Search..." class="search-input" v-model="filter.search">

      <el-dropdown>
        <span class="el-dropdown-link">
          <img src="/images/translation/ic-filter.svg">
        </span>

        <el-dropdown-menu slot="dropdown">  
          <el-dropdown-item v-for="show_type in show_types"
          :class="isActive(show_type, filter.show)">
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
          <el-dropdown-item v-for="sort_type in sort_types"
          :class="isActive(sort_type, filter.sort)">
            <input type="radio" name="sort" :value="sort_type" v-model="filter.sort">
            {{ sort_type }}
          </el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </span>
  </div>  

</template>

<script>
import icon from '../../../icons.vue'

export default {
  name: 'translationBar',

  props: [
    'platforms',
    'filter'
  ],

  components: {
    'icon': icon
  },

  data(){
    return {
      show_types: ["All", "Empty"],
      sort_types: ["Alphabetically", "Recently Updated", "Recently Added"]
    }
  },

  methods: {
    addTerm(){
      this.$emit('addTerm')
    },

    isActive(param, filter_param){
      if(param == filter_param){
        return "radio_active";
      }

      else {
        return "radio_inactive";
      }
    }
  }
}  
</script>