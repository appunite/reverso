<template>
  <div id="registration-panel" class="registrationPanel">
    <el-row type="flex" class="row-bg registrationPanel__row" justify="center">
      <el-col class="main-col registrationPanel__main-col" :xs="16" :sm="9" :md="9" :lg="9">
        <div class="registration-logo registrationPanel__logo">
          <a href="/"><img src="/images/logo-blue.svg"></a>
        </div>
        <router-view></router-view>  
      </el-col>
    </el-row>
  </div>
</template>

<script>

export default {

  name: "registrationPanel",
  data() {
    return {
    }
  }
}


</script>

<style lang="scss">
  .registrationPanel {
    &__logo {
      text-align: center;
    }

    &__main-col {
      margin-top: 100px;
      padding: 15px;
      box-sizing: border-box;

      @media only screen and (max-width: 768px) {
          margin-top: 30px;
      }      
    }

    &__input, &__button {
      width: 100%;       
      min-height: 35px;
      margin: 5px 0 0 0;
      border-radius: 2px;
    }

    &__input {
      background: transparent;      
      font-size: 20px;
      border: 0;      
    }

    &__message {
      font-size: 20px;
      font-weight: 1;
      text-align: center;
      margin: 25px 0;
    }    

  }
</style>
