<template>
  <div id="app" :style="backgroundStyle">
    <div class="bg-pattern"></div>
    <ProductDisplay @category-changed="setCategory" />
  </div>
</template>

<script>
import ProductDisplay from './components/ProductDisplay.vue'

export default {
  name: 'App',
  components: { ProductDisplay },
  data() {
    return {
      bgColor: '#DCDCDC'
    }
  },
  computed: {
    backgroundStyle() {
      // Create a split background (top 65%, bottom 35% white)
      return {
        background: `linear-gradient(to bottom, ${this.bgColor} 65%, #FFFFFF 65%)`
      }
    }
  },
  methods: {
    setCategory(category) {
      if (category === "men's clothing") {
        this.bgColor = '#D6E6FF'
      } else if (category === "women's clothing") {
        this.bgColor = '#FDE2FF'
      } else {
        this.bgColor = '#DCDCDC'
      }
    }
  }
}
</script>