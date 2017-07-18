<template>
  <div id="login-panel">
    <el-row type="flex" class="row-bg" justify="center">
      <el-col class="main-col" :xs="16" :sm="9" :md="9" :lg="9">
        <div class="login-logo">
          <a href="/"><img src="/images/logo-blue.svg"></a>
        </div>
        <router-view></router-view>  
      </el-col>
    </el-row>
  </div>
</template>

<script>

export default {

  name: "loginPanel",
  data() {
    return {
    }
  }
}


</script>

<style lang="scss">
  #login-panel{
    .login-logo {
      text-align: center;
    }

    .main-col{
      margin-top: 100px;
      padding: 15px;
      box-sizing: border-box;
    }

    @media only screen and (max-width: 768px) {
      .main-col{
        margin-top: 30px;
      }
    }

    input, button {
      background: transparent;
      width: 100%;       
      height: 35px;
      margin: 5px 0 0 0;
      border: 0;
      border-radius: 2px;
    }

    input {
      font-size: 20px;
    }

    button.green-btn, button.white-btn {
      color: #ffffff;
      font-weight: 153;
      font-size: 13px;
    }

    button.green-btn {
      background: #38c885;
    }

    button.white-btn {
      background: transparent;
    }

    ::input-placeholder {
      color: #bbb;
      opacity: 1;
    }

    .message {
      font-size: 20px;
      font-weight: 1;
      text-align: center;
      margin: 25px 0;
    }
  }
</style>
