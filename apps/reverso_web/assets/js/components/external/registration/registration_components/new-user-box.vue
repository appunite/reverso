<template>
  <div id="new-user-box" class="newUserBox">
    <img src="/images/mail-illustration.svg">
    <div class="newUserBox__title">
      <h3>Confirmation Link</h3>
      <p>Registration is almost complete!<br> We've sent a confirmation link on your email.</p>
    </div>    
      <router-link class="green-btn newUserBox__button" to="/">Gotcha!</router-link>

 </div>
</template>

<script>
export default {
  name: "newUserBox"
}
</script>

<style lang="scss">
.newUserBox {
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
