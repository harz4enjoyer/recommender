<script setup>
import { RouterLink, RouterView } from 'vue-router'
import Navbar from './components/Navbar.vue'
import Head from './components/Head.vue'
import Food from './components/Food.vue'
</script>

<template>
  <Navbar />
  <Food />
  <RouterView />
</template>

<style scoped>
header {
  line-height: 1.5;
  max-height: 100vh;
}
</style>
