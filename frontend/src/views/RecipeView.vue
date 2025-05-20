<script setup>
import { ref, onMounted } from 'vue';
import Content from '@/components/Content.vue';
import LoadingScreen from '@/components/LoadingScreen.vue';
import Editor from '@/components/RecipeEditor.vue'
const isLoading = ref(true);

// Simulate loading delay
onMounted(() => {
  setTimeout(() => {
    isLoading.value = false;
  }, 200); // 2 seconds delay
});
</script>

<template>
  <div>
    <LoadingScreen :isLoading="isLoading" />
    <Content v-if="!isLoading">

      <Editor />
    </Content>
  </div>
</template>
