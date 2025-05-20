<template>
  <div class="home-interface">
    <h1>Rezeptübersicht</h1>

    <!-- Search Bar and Toggle -->
    <input v-model="searchQuery" type="text" placeholder="🔍 Rezept suchen..." class="search-bar" />
    <div class="toggle-container">
      <span :class="{ active: selectedCategory === 'Backen' }">Backen</span>
      <label class="switch">
        <input type="checkbox" v-model="isCooking">
        <span class="slider"></span>
      </label>
      <span :class="{ active: selectedCategory === 'Kochen' }">Kochen</span>
    </div>

    <button class="add-recipe-button" @click="openCreateRecipeModal">+</button>

    <div v-if="loading">Lade Rezepte...</div>

    <div v-else class="recipe-list">
      <RecipeCard v-for="recipe in filteredRecipes" :key="recipe.id" :recipe="recipe"
        @click="openEditRecipeModal(recipe)" @delete="deleteRecipe(recipe.id)" />
      <p v-if="filteredRecipes.length === 0">Kein Rezept gefunden.</p>
    </div>

    <!-- Recipe Modal -->
    <div v-if="isModalOpen" class="modal">
      <div class="modal-content">
        <h3>{{ editingRecipe ? 'Name' : 'Neues Rezept' }}</h3>

        <!-- Recipe Name -->
        <input v-model="currentRecipe.name" placeholder="Rezeptname" class="modal-input" />

        <!-- Ingredients -->
        <div class="ingredient-step-container">
          <h3>Zutaten</h3>
          <div v-for="(ingredient, index) in currentRecipe.zutaten" :key="index" class="dynamic-field">
            <input v-model="ingredient.name" placeholder="Zutat" class="modal-input small-input" />
            <input v-model="ingredient.menge" placeholder="Menge" class="modal-input small-input" />
            <input v-model="ingredient.einheit" placeholder="Einheit" class="modal-input small-input" />
            <button @click="removeIngredient(index)" class="remove-button">-</button>
          </div>
          <button @click="addIngredient" class="add-button">+ Zutat hinzufügen</button>
        </div>

        <!-- Instructions -->
        <div class="ingredient-step-container">
          <h3>Zubereitung</h3>
          <div v-for="(step, index) in currentRecipe.anleitung" :key="index" class="dynamic-field">
            <textarea v-model="currentRecipe.anleitung[index]" placeholder="Schritt"
              class="modal-input small-textarea" />
            <button @click="removeStep(index)" class="remove-button">-</button>
          </div>
          <button @click="addStep" class="add-button">+ Schritt hinzufügen</button>
        </div>

        <!-- Category -->
        <div class="category-container">
          <label>Kategorie:</label>
          <select v-model="currentRecipe.kategorie" class="modal-input">
            <option value="Backen">Backen</option>
            <option value="Kochen">Kochen</option>
          </select>
        </div>

        <!-- Vegan/Vegetarian -->
        <div class="checkbox-container">
          <label>
            <input type="checkbox" v-model="currentRecipe.vegan" /> Vegan
          </label>
          <label>
            <input type="checkbox" v-model="currentRecipe.vegetarisch" /> Vegetarisch
          </label>
        </div>

        <!-- Save, Delete, and Cancel Buttons -->
        <div class="button-container">
          <button @click="saveRecipe" class="save-button">Speichern</button>
          <button v-if="editingRecipe" @click="deleteRecipe(currentRecipe.id)" class="delete-button">Löschen</button>
          <button @click="closeModal" class="cancel-button">Abbrechen</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import RecipeCard from './RecipeCard.vue';

// API URL
const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000/api';

const rezepte = ref([]);
const loading = ref(true);
const isCooking = ref(false);
const searchQuery = ref("");
const isModalOpen = ref(false);
const editingRecipe = ref(null);
const currentRecipe = ref({
  id: '',
  name: '',
  kategorie: '',
  zutaten: [],
  anleitung: [],
  vegan: false,
  vegetarisch: false
});

// Fetch JSON data from the API
onMounted(async () => {
  try {
    const response = await fetch(`${API_URL}/json`);
    if (!response.ok) throw new Error('Fehler beim Laden der Rezepte');
    const data = await response.json();
    rezepte.value = data.rezepte;
  } catch (error) {
    console.error(error);
  } finally {
    loading.value = false;
  }
});

const selectedCategory = computed(() => (isCooking.value ? 'Kochen' : 'Backen'));

const filteredRecipes = computed(() => {
  return rezepte.value
    .filter((recipe) => recipe.kategorie === selectedCategory.value)
    .filter((recipe) =>
      recipe.name.toLowerCase().includes(searchQuery.value.toLowerCase())
    );
});

// Editing Overlay

const openEditRecipeModal = (recipe) => {
  currentRecipe.value = { ...recipe };
  editingRecipe.value = recipe;
  isModalOpen.value = true;
};

const openCreateRecipeModal = () => {
  currentRecipe.value = {
    id: '',
    name: '',
    kategorie: selectedCategory.value,
    zutaten: [],
    anleitung: [],
    vegan: false,
    vegetarisch: false
  };
  editingRecipe.value = null;
  isModalOpen.value = true;
};

const addIngredient = () => {
  currentRecipe.value.zutaten.push({ name: '', menge: '', einheit: '' });
};

const removeIngredient = (index) => {
  currentRecipe.value.zutaten.splice(index, 1);
};

const addStep = () => {
  currentRecipe.value.anleitung.push('');
};

const removeStep = (index) => {
  currentRecipe.value.anleitung.splice(index, 1);
};

// Save JSON data to the API
const saveJson = async () => {
  try {
    const response = await fetch(`${API_URL}/json`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ rezepte: rezepte.value }),
      credentials: 'include'
    });

    if (!response.ok) {
      throw new Error('Server response was not ok');
    }

    alert('Rezepte erfolgreich gespeichert!');
  } catch (error) {
    console.error('Fehler beim Speichern:', error);
    alert('Fehler beim Speichern der Rezepte!');
  }
};

const saveRecipe = async () => {
  if (editingRecipe.value) {
    const index = rezepte.value.findIndex(r => r.id === editingRecipe.value.id);
    if (index !== -1) {
      rezepte.value[index] = { ...currentRecipe.value };
    }
  } else {
    currentRecipe.value.id = Date.now().toString();
    rezepte.value.push({ ...currentRecipe.value });
  }
  await saveJson();
  closeModal();
};

const deleteRecipe = (id) => {
  rezepte.value = rezepte.value.filter(recipe => recipe.id !== id);
  saveJson();
  closeModal();
};

const closeModal = () => {
  isModalOpen.value = false;
};
</script>

<style scoped>
.home-interface {
  padding: 16px;
  text-align: center;
}

.add-recipe-button {
  font-size: 36px;
  background-color: #ff9800;
  color: white;
  border-radius: 50%;
  width: 50px;
  height: 50px;
  border: none;
  display: inline-block;
  margin: 20px 0;
  cursor: pointer;
}

.toggle-container {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  margin: 20px 0;
  font-size: 18px;
}

.active {
  font-weight: bold;
  color: #ff9800;
}

.switch {
  position: relative;
  display: inline-block;
  width: 50px;
  height: 28px;
}

.switch input {
  opacity: 0;
  width: 0;
  height: 0;
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: white;
  transition: transform 0.4s;
  border-radius: 34px;
}

.slider:before {
  position: absolute;
  content: "";
  height: 22px;
  width: 22px;
  left: 3px;
  bottom: 3px;
  background-color: #ffcc00;
  transition: transform 0.4s;
  border-radius: 50%;
}

input:checked+.slider:before {
  transform: translateX(22px);
}

.search-bar {
  width: 80%;
  max-width: 400px;
  padding: 10px;
  font-size: 16px;
  border: 1px solid #ccc;
  border-radius: 5px;
  margin-bottom: 20px;
}

.recipe-list {
  display: flex;
  flex-wrap: wrap;
  gap: 16px;
  justify-content: center;
}

.modal {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
}

.modal-content {
  background-color: #2A2A2A;
  padding: 20px;
  border-radius: 8px;
  width: 400px;
  max-height: 90vh;
  overflow-y: auto;
  border: 3px solid #ffcc00;
}

.modal-content h2 {
  margin-top: 0;
  font-size: 1.5em;
  color: #333;
}

.modal-input {
  width: 100%;
  padding: 8px;
  margin: 8px 0;
  border: 1px solid #ccc;
  border-radius: 4px;
}

.small-input {
  width: 30%;
  margin-right: 5px;
}

.small-textarea {
  width: 80%;
  height: 60px;
  resize: vertical;
}

.ingredient-step-container {
  margin-bottom: 16px;
}

.dynamic-field {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 8px;
}

.remove-button {
  background-color: #ff4444;
  color: white;
  border: none;
  border-radius: 4px;
  padding: 4px 8px;
  cursor: pointer;
}

.add-button {
  background-color: #4caf50;
  color: white;
  border: none;
  border-radius: 4px;
  padding: 8px 16px;
  cursor: pointer;
}

.category-container,
.checkbox-container {
  margin: 16px 0;
}

.checkbox-container label {
  margin-right: 16px;
}

.button-container {
  display: flex;
  justify-content: flex-end;
  gap: 8px;
  align-items: center;
}

.save-button {
  background-color: #4caf50;
  color: white;
  border: none;
  border-radius: 4px;
  padding: 8px 16px;
  cursor: pointer;
}

.delete-button {
  background-color: #ff4444;
  color: white;
  border: none;
  border-radius: 4px;
  padding: 8px 16px;
  cursor: pointer;
}

.cancel-button {
  background-color: #ccc;
  color: #333;
  border: none;
  border-radius: 4px;
  padding: 8px 16px;
  cursor: pointer;
}
</style>
