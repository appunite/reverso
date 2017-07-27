export default {
  includesPlatform(array, platform_name){
      return _.includes(array, platform_name);
  },

  formReady(data){
    for (var i = 0; i < data.length; i++) {
      if (data[i] == false || data[i] == null) return false;
    }

    return true;
  }
}