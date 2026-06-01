<template>
  <div class="product-container">
    <!-- Loading -->
    <div v-if="loading" class="loading-wrapper">
      <div class="loader"></div>
    </div>

    <!-- Product Card -->
    <div v-else-if="product && isValidCategory" class="product-card" :class="themeClass">
      <!-- Left: Image -->
      <div class="product-image-area">
        <img :src="product.image" :alt="product.title" class="product-image" @error="handleImageError" />
      </div>

      <!-- Right: Info -->
      <div class="product-info-area">
        <h1 class="product-title">{{ product.title }}</h1>
        
        <div class="category-rating">
          <span class="product-category">{{ product.category }}</span>
          <div class="rating-wrapper">
            <span class="rating-value">{{ product.rating.rate }}/5</span>
            <div class="circles">
              <span 
                v-for="star in 5" 
                :key="star" 
                class="circle" 
                :class="{ filled: star <= Math.round(product.rating.rate) }"
              ></span>
            </div>
          </div>
        </div>

        <hr class="divider" />

        <p class="product-description">{{ product.description }}</p>

        <hr class="divider" />

        <div class="price">${{ product.price.toFixed(2) }}</div>

        <div class="button-group">
          <button class="btn btn-buy" @click="buyNow">Buy now</button>
          <button class="btn btn-next" @click="nextProduct">Next product</button>
        </div>
      </div>
    </div>

    <!-- Unavailable -->
    <div v-else class="unavailable-card">
        <div class="unavailable-content">
          <div class="sad-face">:(</div>
          <p class="unavailable-message">This product is unavailable to show</p>
          <button class="btn btn-unavailable-next" @click="nextProduct">Next product</button>
        </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ProductDisplay',
  data() {
    return {
      currentIndex: 1,
      product: null,
      category: null,
      loading: true,
      isValidCategory: false
    }
  },
  computed: {
    themeClass() {
      if (this.category === "men's clothing") return 'theme-men'
      if (this.category === "women's clothing") return 'theme-women'
      return 'theme-unavailable'
    }
  },
  watch: {
    category: {
      handler(newVal) {
        this.$emit('category-changed', newVal)
      },
      immediate: true
    }
  },
  mounted() {
    this.fetchProduct()
  },
  methods: {
    async fetchProduct() {
      this.loading = true
      try {
        const res = await fetch(`https://fakestoreapi.com/products/${this.currentIndex}`)
        const data = await res.json()
        
        if (data.category === "men's clothing" || data.category === "women's clothing") {
          this.product = data
          this.category = data.category
          this.isValidCategory = true
        } else {
          this.isValidCategory = false
          this.category = null
        }
      } catch (err) {
        console.error(err)
        this.isValidCategory = false
        this.category = null
      } finally {
        this.loading = false
      }
    },
    nextProduct() {
      this.currentIndex = this.currentIndex + 1
      if (this.currentIndex > 20) this.currentIndex = 1
      this.fetchProduct()
    },
    buyNow() {
      // no-op for now, or you could alert
    },
    handleImageError(e) {
      e.target.src = 'https://picsum.photos/300/300?text=No+Image'
    }
  }
}
</script>