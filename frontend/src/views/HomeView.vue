
<template>
  <div class="page-layout">
    <!-- Recommendations Box -->
    <div class="recommendations-box">
      <h3 class="recommendations-title">Recommendations</h3>
      <div class="recommendations-list">
                <button
          v-for="rec in recommendations"
          :key="rec.name"
          class="recommendation-card"
          @click="reviewRecommendation(rec)"
        >
          <strong>{{ rec.name }}</strong>
          <span class="category">{{ rec.category.replace('_', ' ') }}</span>
        </button>
      </div>
    </div>

    <!-- Main Rating Section -->
    <div class="page">
      <div class="item-card">
        <div v-if="loading" class="loading">Loading...</div>
        <div v-else-if="error" class="error">Error: {{ error }}</div>
        <div v-else-if="item" class="content">
          <h2>{{ item.name }}</h2>
          <span class="category">{{ item.category.replace('_', ' ') }}</span>
          <div class="rating-buttons">
            <button
              v-for="n in 11"
              :key="n"
              class="rating-btn"
              :style="getRatingButtonColor(n - 1)"
              @click="submitReview(n - 1)"
              :disabled="loading"
            >
              {{ n - 1 }}
            </button>
          </div>
        </div>
      </div>
      <button @click="fetchItem" class="refresh-btn" :disabled="loading">
        {{ loading ? 'Loading...' : 'Get New Item' }}
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';

const item = ref(null);
const loading = ref(false);
const error = ref(null);
const recommendations = ref([]);

const fetchItem = async () => {
  loading.value = true;
  error.value = null;
  try {
    const response = await fetch('http://localhost:8080/api/random_unreviewed');
    if (!response.ok) {
      throw new Error(`Failed to fetch item: ${response.status}`);
    }
    const data = await response.json();
    item.value = data;
  } catch (err) {
    error.value = err.message;
  } finally {
    loading.value = false;
  }
};

const fetchRecommendations = async () => {
  try {
    const response = await fetch('http://localhost:8080/api/recommendations');
    if (!response.ok) {
      throw new Error(`Failed to fetch recommendations: ${response.status}`);
    }
    const data = await response.json();
    recommendations.value = data;
  } catch (err) {
    console.error('Error fetching recommendations:', err.message);
  }
};

const submitReview = async (rating) => {
  if (!item.value) return;
  loading.value = true;
  error.value = null;
  try {
    const response = await fetch('http://localhost:8080/api/reviews', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        item: item.value,
        rating: rating,
      }),
    });
    if (!response.ok) {
      throw new Error(`Review failed: ${response.status}`);
    }
    await fetchItem();             // Load new item
    await fetchRecommendations();  // Refresh recommendations
  } catch (err) {
    error.value = err.message;
  } finally {
    loading.value = false;
  }
};

const getRatingButtonColor = (rating) => {
  const ratio = rating / 10;
  const red = Math.round(255 * (1 - ratio));
  const green = Math.round(255 * ratio);
  return { backgroundColor: `rgb(${red}, ${green}, 0)` };
};

onMounted(() => {
  fetchItem();
  fetchRecommendations();
});

const reviewRecommendation = (recommendation) => {
  item.value = recommendation;
};
</script>

<style scoped>
@import '../assets/typography-styles.css';

.page-layout {
  display: flex;
  gap: 20px;
  padding: 20px;
  max-width: 1200px;
  margin: 0 auto;
}

/* Box around recommendations */
.recommendations-box {
  flex: 1;
  max-width: 400px;
  border: 2px solid #FFD700;
  border-radius: 12px;
  padding: 12px;
  background-color: #2A2A2A;
}

.recommendations-title {
  font-size: 1.1em;
  color: #FFD700;
  margin-bottom: 10px;
  text-align: center;
}

.recommendations-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
  max-height: 500px;
  overflow-y: auto;
}

.recommendation-card {
  background-color: #3b3b3b;
  border-left: 4px solid #f5bd16;
  padding: 10px 12px;
  border-radius: 8px;
  font-size: 0.9em;
  line-height: 1.4;
  color: white;
  display: flex;
  flex-direction: column;
  cursor: pointer;
  transition: background-color 0.2s;
}

.recommendation-card:hover {
  background-color: #4a4a4a;
}

.recommendation-card .category {
  font-size: 0.8em;
  color: #ccc;
  text-transform: capitalize;
}

.page {
  flex: 2;
}

.item-card {
  border: 2px solid #DFAE07;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 4px 4px 12px rgba(0, 0, 0, 0.2);
  margin-bottom: 20px;
  min-height: 120px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background-color: #2A2A2A;
}

.loading, .error {
  text-align: center;
  color: #666;
}

.error {
  color: #dc3545;
}

.content {
  text-align: center;
}

.content h2 {
  margin: 0 0 12px 0;
  color: #FFD700;
}

.category {
  background: #ff9800;
  color: #FFFFFF;
  padding: 6px 12px;
  border-radius: 16px;
  font-size: 0.9em;
  text-transform: capitalize;
  margin-bottom: 12px;
  display: inline-block;
}

.rating-buttons {
  margin-top: 16px;
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 8px;
}

.rating-btn {
  padding: 0.5rem 1rem;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 1em;
  transition: background-color 0.2s;
}

.rating-btn:hover:not(:disabled) {
  filter: brightness(1.2);
}

.rating-btn:disabled {
  background: #6c757d;
  cursor: not-allowed;
}

.refresh-btn {
  background-color: #2A2A2A;
  color: white;
  border: 2px solid #DFAE07;
  padding: 12px 24px;
  border-radius: 6px;
  cursor: pointer;
  font-size: 1em;
  width: 100%;
  transition: all 0.2s ease;
}

.refresh-btn:hover:not(:disabled) {
  background-color: #3A3A3A;
  border-color: #FFD700;
  color: #FFD700;
}

.refresh-btn:disabled {
  background: #6c757d;
  border-color: #6c757d;
  cursor: not-allowed;
}
</style>

