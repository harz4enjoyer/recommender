<template>
  <div class="recipe-card">
    <h2>{{ recipe.name }}</h2>
    <p class="category"><strong>Kategorie:</strong> {{ recipe.kategorie }}</p>

    <div class="section">
      <h3>Zutaten</h3>
      <ul>
        <li v-for="zutat in recipe.zutaten" :key="zutat.name">
          <span class="highlight">{{ zutat.menge }} {{ zutat.einheit }}</span> {{ zutat.name }}
        </li>
      </ul>
    </div>

    <div class="section">
      <h3>Anleitung</h3>
      <ol>
        <li v-for="(schritt, index) in recipe.anleitung" :key="index">
          {{ schritt }}
        </li>
      </ol>
    </div>

    <p class="badge vegan" v-if="recipe.vegan">🌱 Vegan</p>
    <p class="badge vegetarisch" v-else-if="recipe.vegetarisch">🥦 Vegetarisch</p>
  </div>
</template>

<script setup>
defineProps({
  recipe: Object
});
</script>

<style scoped>
.recipe-card {
  border: 2px solid #DFAE07;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 4px 4px 12px rgba(0, 0, 0, 0.2);
  max-width: 350px;
  background-color: #2A2A2A;
  color: #fff;
  font-family: Arial, sans-serif;
}

h2 {
  margin-top: 0;
  font-size: 22px;
  color: #FFD700;
}

.category {
  font-style: italic;
  color: #E0C785;
}

.section {
  margin-top: 12px;
}

h3 {
  font-size: 18px;
  color: #FFD700;
  border-bottom: 2px solid #DFAE07;
  padding-bottom: 4px;
  margin-bottom: 8px;
}

ul,
ol {
  padding-left: 18px;
}

li {
  margin-bottom: 6px;
}

.highlight {
  color: #FFD700;
  font-weight: bold;
}

.badge {
  display: inline-block;
  margin-top: 12px;
  padding: 6px 12px;
  border-radius: 8px;
  font-weight: bold;
}

.vegan {
  background-color: #4CAF50;
  color: white;
}

.vegetarisch {
  background-color: #8BC34A;
  color: white;
}
</style>
