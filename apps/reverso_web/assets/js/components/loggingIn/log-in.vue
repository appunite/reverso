<template>

	<div class="box-container">
    <center>Reverso.co</center>
    <loginBox></loginBox>
    
	</div>
</template>

<script>
import loginBox from './login-box.vue'


export default {
  components: {
    'loginBox': loginBox
  },
  data() {
    return {

    }
  }
}
</script>

<style>

.box-container {
  margin: 140px auto auto auto;
  border: 3px solid green;
  width: 30%;
  padding: 10px;
}

input {
    background: transparent;
    width: 100%;
    border: none;
    padding: 10px;
  }

  button {
    background: green;
    color: white;
    width: 100%;
    border: none;
  }

  h3 {
    text-align: center;
    font-weight: normal;
  }

</style>
