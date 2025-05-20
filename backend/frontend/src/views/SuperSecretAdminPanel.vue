<script setup>
import { ref, onMounted } from 'vue';
import Content from '@/components/Content.vue';
import LoadingScreen from '@/components/LoadingScreen.vue';
import Edit from '@/components/JsonEditor.vue';

const isLoading = ref(true);

// Simulate loading delay
onMounted(() => {
  setTimeout(() => {
    isLoading.value = false;
  }, 700); // 2 seconds delay
});
</script>

<template>
  <div>
    <LoadingScreen :isLoading="isLoading" />
    <Content v-if="!isLoading">
      <h1>Edit the Json (dont hurt it) </h1>
      <Edit />
    </Content>
  </div>
</template>
