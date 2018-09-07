<template>
  <div>
    <h1>Hello from Vue Landing Page: <span v-if="info != null">{{ info }}</span></h1>
    <v-btn class="primary" @click="setInfo" small>Click</v-btn>
  </div>

</template>

<script>
export default {
  data () {
    return {
      info: null
    }
  },
  methods: {
    setInfo () {
      this.$http.get('https://jsonplaceholder.typicode.com/todos/1').then(res => {
        this.info = res.data.title
      })
    }
  }
}
</script>
