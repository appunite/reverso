<template> 
  <span class="contributorsInitials">
    <a class="contributorsInitials__button">
        <div v-for="initials in allContributorsInitials" class="contributorsInitials__circle">
          {{initials}}
        </div>
    </a>
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
      &, &:link, &:visited, &:hover, &:active {  
        width: 100px;
        margin: 10px 10px;
        padding: 0;
        border: none;
        background: transparent;
        display: flex;
        justify-content: flex-end;
        text-decoration: none;
      }
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
      position: relative;

      margin-left: -6px;
      text-align: center;
    }
  }
</style>