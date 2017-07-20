<template>	
  <el-table
    :data="translations"
    border
    style="width: 100%">

    <el-table-column
      prop="basic"
      label="reference language">


      <template scope="scope">
	      <el-popover trigger="hover" placement="bottom">
          <p>{{ scope.row.platform_key }}</p>
          <div slot="reference" class="name-wrapper">
            {{ scope.row.basic }}
          </div>
        </el-popover>
        kosz
	    </template>

    </el-table-column>

    <el-table-column
      prop="translation"
      label="translation">
    </el-table-column>
    
    <el-table-column
      prop="description"
      label="developer description">
    </el-table-column>
  
  </el-table>
</template>

<script>

export default {
	name: "translationTable",
	data () {
		return {
			translations: [
			{
				basic: "elo",
		    platform_key: "elo_k",
		    description: "",
		    translation: "xdxd",
			  platform_id: 1
		  },
		  {
				basic: "elo1",
		    platform_key: "elo1_k",
		    description: "",
		    translation: "xdxd1",
			  platform_id: 1
		  },
		  {
				basic: "elo3",
		    platform_key: "elo3_k",
		    description: "",
		    translation: "xdxd3",
			  platform_id: 2
		  },
		  {
				basic: "elo4",
		    platform_key: "elo4_k",
		    description: "",
		    translation: "xdxd4",
			  platform_id: 2
		  }
		  ]
		}
	},
	methods: {
	}
}
	
</script>