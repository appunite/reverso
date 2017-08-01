<template> 
  <span class="contributorsInitials">
    <button class="contributorsInitials__button">
        <div v-for="initials in allContributorsInitials" class="contributorsInitials__circle">{{initials}}</div>
    </button>
  </span>
</template>

<script>
  export default {
    name: "contributorsInitials",

    props: [
      'contributors'
    ],

    data(){
      return{
        contributorsNum: -1,
      }
    },

    computed: {
      allContributorsInitials() {
        var result = [];
        var max = (this.contributorsNum > 4) ? 4 : this.contributorsNum;
        var difference = this.contributorsNum - max;

        for(var i = 0; i < max; i++) {
          result.push( this.getSingleInitials(this.contributors[i]) ); 
        }

        if(difference > 0) {
          result.push( "+" + difference );
        }

        return result;
      }
    },

    mounted() {
      this.contributorsNum = this.contributors.length;
    },

    methods: {
      getSingleInitials(user) {
        var nameElements = user.user_name.split(" ");
        var elementsNum = nameElements.length;

        var result = "";
        if(elementsNum > 1)
          result = nameElements[0].charAt(0) + nameElements[elementsNum-1].charAt(0);
        else
          result = nameElements[0].substring(0, 2);

        return result.toUpperCase();
      }
    },


  }
</script>

<style lang="scss">
  $purple: #5861E6;

  .contributorsInitials {
    &__button {
      width: 100px;
      margin: 10px 0;

      padding: 0;
      border: none;
      background: transparent;
    }

    &__circle {
      display: inline-block;
      width: 20px;
      height: 20px;

      color: $purple;
      font-size: 8px;
      line-height: 18px;

      border-radius: 50%;

      background: #ffffff;
      border: 1px solid $purple;

      float: left;

      position: relative;
      left: 0px;
    }

    &__circle:nth-child(1) {
      left: 0;
    }

    &__circle:nth-child(2) {
      left: -6px;
    }

    &__circle:nth-child(3) {
      left: -12px;
    }

    &__circle:nth-child(4) {
      left: -18px;
    }

    &__circle:nth-child(5) {
      left: -24px;
    }        
  }
</style>