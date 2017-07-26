<template>
  <div id="reset-pass-confirm-info" class="resetPassConfirmInfo">
    <img src="/images/mail-illustration.svg">
    <div class="resetPassConfirmInfo__title">
      <h3>Check your Mailbox</h3>
      <p>We've sent you a link to reset your current password and define a new one.</p>
    </div>    
      <router-link class="green-btn resetPassConfirmInfo__button" to="/">Gotcha!</router-link>

 </div>
</template>

<script>
export default {
  name: "resetPassConfirmInfo"
}
</script>

<style lang="scss">
.resetPassConfirmInfo {
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
    color: #444;
    margin-bottom: 30px;
  }
}
</style>