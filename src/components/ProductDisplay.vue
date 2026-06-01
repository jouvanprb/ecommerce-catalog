<template>
  <div class="product-display">
    <!-- Loading State -->
    <div v-if="loading" class="loader-container">
      <div class="loader"></div>
    </div>

    <!-- Unavailable Product -->
    <div v-else-if="!isValidCategory" class="unavailable-card">
      <p class="unavailable-message">This product is unavailable to show</p>
      <button class="btn btn-next" @click="nextProduct">Next product</button>
    </div>

    <!-- Men's Clothing -->
    <div v-else-if="category === 'men\'s clothing'" class="product-card men-theme">
      <div class="product-image-container">
        <img 
          :src="product.image" 
          :alt="product.title"
          class="product-image"
          @error="handleImageError"
        />
      </div>
      
      <div class="product-info">
        <h2 class="product-title">{{ product.title }}</h2>
        <p class="product-category">{{ product.category }}</p>
        
        <div class="rating">
          <div class="stars">
            <span 
              v-for="n in 5" 
              :key="n"
              class="star"
              :class="{ filled: n <= Math.round(product.rating.rate) }"
            >
              ★
            </span>
          </div>
          <span class="rating-value">{{ product.rating.rate }}/5</span>
        </div>
        
        <p class="product-description">{{ product.description }}</p>
        
        <div class="product-price">${{ product.price.toFixed(2) }}</div>
        
        <div class="button-group">
          <button class="btn btn-buy" @click="buyNow">Buy now</button>
          <button class="btn btn-next" @click="nextProduct">Next product</button>
        </div>
      </div>
    </div>

    <!-- Women's Clothing -->
    <div v-else-if="category === 'women\'s clothing'" class="product-card women-theme">
      <div class="product-image-container">
        <img 
          :src="product.image" 
          :alt="product.title"
          class="product-image"
          @error="handleImageError"
        />
      </div>
      
      <div class="product-info">
        <h2 class="product-title">{{ product.title }}</h2>
        <p class="product-category">{{ product.category }}</p>
        
        <div class="rating">
          <div class="stars">
            <span 
              v-for="n in 5" 
              :key="n"
              class="star"
              :class="{ filled: n <= Math.round(product.rating.rate) }"
            >
              ★
            </span>
          </div>
          <span class="rating-value">{{ product.rating.rate }}/5</span>
        </div>
        
        <p class="product-description">{{ product.description }}</p>
        
        <div class="product-price">${{ product.price.toFixed(2) }}</div>
        
        <div class="button-group">
          <button class="btn btn-buy" @click="buyNow">Buy now</button>
          <button class="btn btn-next" @click="nextProduct">Next product</button>
        </div>
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
  mounted() {
    this.fetchProduct()
  },
  methods: {
    async fetchProduct() {
      this.loading = true
      this.isValidCategory = false
      this.product = null
      this.category = null
      
      try {
        const response = await fetch(`https://fakestoreapi.com/products/${this.currentIndex}`)
        const data = await response.json()
        
        if (data.category === 'men\'s clothing' || data.category === 'women\'s clothing') {
          this.product = data
          this.category = data.category
          this.isValidCategory = true
        } else {
          this.isValidCategory = false
        }
      } catch (error) {
        console.error('Error:', error)
        this.isValidCategory = false
      } finally {
        this.loading = false
      }
    },
    
    nextProduct() {
      this.currentIndex = this.currentIndex + 1
      if (this.currentIndex > 20) {
        this.currentIndex = 1
      }
      this.fetchProduct()
    },
    
    buyNow() {
      alert(`✨ "${this.product.title}" added to cart! ✨`)
    },
    
    handleImageError(e) {
      e.target.src = 'https://via.placeholder.com/300x300?text=No+Image'
    }
  }
}
</script>

<style scoped>
.product-display {
  width: 100%;
}
</style>