<script setup>
import Content from '@/components/Content.vue'
import { ref } from 'vue'

const username = ref('')
const password = ref('')
const message = ref('')
const isLoggedIn = ref(false)

const handleLogin = async () => {
  try {
    const response = await fetch('http://localhost:8080/api/login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        username: username.value,
        password: password.value
      })
    })
    if (response.ok) {
      message.value = 'Login successful!'
      isLoggedIn.value = true
    } else {
      message.value = 'Login failed. Please check your credentials.'
    }
  } catch (error) {
    message.value = 'Error connecting to server.'
    console.error('Login error:', error)
  }
}

const handleLogout = async () => {
  try {
    const response = await fetch('http://localhost:8080/api/logout', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      }
    })
    if (response.ok) {
      message.value = 'Logged out successfully!'
      isLoggedIn.value = false
      username.value = ''
      password.value = ''
    } else {
      message.value = 'Logout failed.'
    }
  } catch (error) {
    message.value = 'Error connecting to server.'
    console.error('Logout error:', error)
  }
}
</script>

<template>
  <Content>
    <h2>{{ isLoggedIn ? 'Dashboard' : 'Login' }}</h2>

    <form v-if="!isLoggedIn" @submit.prevent="handleLogin">
      <div>
        <label for="username">Username:</label>
        <input type="text" id="username" v-model="username" required>
      </div>
      <div>
        <label for="password">Password:</label>
        <input type="password" id="password" v-model="password" required>
      </div>
      <button type="submit">Login</button>
    </form>

    <div v-if="isLoggedIn">
      <p>Welcome! You are logged in as {{username}}. </p>
      <button @click="handleLogout">Logout</button>
    </div>

    <div v-if="message">{{ message }}</div>
  </Content>
</template>

<style scoped>
@import '../assets/typography-styles.css'
</style>
