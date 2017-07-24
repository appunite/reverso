<template>
  <div id="account-activated" class="accountActivated">
    <img src="/images/mail-illustration.svg">
    <h3 class="accountActivated__title">Your account is now activated!</h3>
    <router-link class="green-btn accountActivated__button" to="/">Gotcha!</router-link>
 </div>
</template>

<script>
export default {
  name: "accountActivated",
  data() {
    return {

    } 
  },

  methods: {
  }

}
</script>

<style lang="scss">
.accountActivated {
  text-align: center;
  
  &__button {
    &, &:link, &:visited, &:hover, &:active {
      color: #ffffff;

      display: block;
      width: 50%;
      min-height: 35px; 

      margin: 5px auto 0 auto;
      border-radius: 2px;
        
      font-weight: 153;
      font-size: 13px;
      text-align: center;
      text-decoration: none;
      line-height: 33px;
    }
  }

  &__title {
    margin-bottom: 30px;
  }
}
</style>