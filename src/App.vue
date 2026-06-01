<template>
  <div id="app">
    <div class="app-container">
      <ProductDisplay />
    </div>
  </div>
</template>

<script>
import ProductDisplay from './components/ProductDisplay.vue'

export default {
  name: 'App',
  components: {
    ProductDisplay
  }
}
</script>

<style>
@import './assets/style/main.css';

#app {
  width: 100%;
  min-height: 100vh;
}

.app-container {
  width: 100%;
  max-width: 600px;
  margin: 0 auto;
}
</style>