<template>

	<div class="login-box-container" style="margin: 140px auto auto auto; width: 30%; border: 3px solid green; padding: 10px;">
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
