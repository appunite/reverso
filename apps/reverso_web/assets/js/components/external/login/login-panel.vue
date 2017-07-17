<template>
  <div id="login-panel">
    <el-row type="flex" class="row-bg" justify="center">
      <el-col class="main-col" :xs="16" :sm="18" :md="4" :lg="3">
        <div class="login-logo">
          <img src="/images/login-logo.png">
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

<style>
  #login-panel .login-logo {
    text-align: center;
  }

  #login-panel .main-col{
    background: red;
    margin-top: 100px;
    padding: 15px;
    box-sizing: border-box;
  }

  @media only screen and (max-width: 768px) {
    #login-panel .main-col{
      margin-top: 30px;
    }
  }

  #login-panel input {
    font-size: 20px;
    height: 35px;
    width: 100%;
    margin: 5px 0 0 0;
    border: 0;
  }

  #login-panel button {
    width: 100%;
    margin: 5px 0 0 0;
    border: 0;
  }

  #login-panel ::-webkit-input-placeholder { /* WebKit, Blink, Edge */
      color:    #888;
  }
  #login-panel :-moz-placeholder { /* Mozilla Firefox 4 to 18 */
    color:    #888;
    opacity:  1;
  }
  #login-panel ::-moz-placeholder { /* Mozilla Firefox 19+ */
    color:    #888;
    opacity:  1;
  }
  #login-panel :-ms-input-placeholder { /* Internet Explorer 10-11 */
    color:    #888;
  }
  #login-panel ::-ms-input-placeholder { /* Microsoft Edge */
    color:    #888;
  }

</style>
