<script setup>
import Content from '@/components/Content.vue'
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'

const username = ref('')
const password = ref('')
const confirmPassword = ref('')
const message = ref('')
const isLoggedIn = ref(false)
const isRegistering = ref(false)
const isLoading = ref(true)
const router = useRouter()

// Check login status on component mount
const checkLoginStatus = async () => {
  try {
    const response = await fetch('http://localhost:8080/api/login_status', {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      },
      credentials: 'include' // Include cookies for session management
    })

    if (response.ok) {
      const data = await response.json()
      if (data && data.username) {
        username.value = data.username
        isLoggedIn.value = true
      } else {
        isLoggedIn.value = false
      }
    } else {
      isLoggedIn.value = false
    }
  } catch (error) {
    console.error('Error checking login status:', error)
    isLoggedIn.value = false
  } finally {
    isLoading.value = false
  }
}

const handleLogin = async () => {
  try {
    const response = await fetch('http://localhost:8080/api/login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      credentials: 'include', // Include cookies for session management
      body: JSON.stringify({
        username: username.value,
        password: password.value
      })
    })
    if (response.ok) {
      message.value = 'Login successful!'
      isLoggedIn.value = true
      password.value = '' // Clear password after successful login
      router.push({ name: 'Home' })
    } else {
      message.value = 'Login failed. Please check your credentials.'
    }
  } catch (error) {
    message.value = 'Error connecting to server.'
    console.error('Login error:', error)
  }
}

const handleRegister = async () => {
  if (password.value !== confirmPassword.value) {
    message.value = 'Passwords do not match.'
    return
  }

  try {
    const response = await fetch('http://localhost:8080/api/register', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      credentials: 'include', // Include cookies for session management
      body: JSON.stringify({
        username: username.value,
        password: password.value
      })
    })

    if (response.ok) {
      message.value = 'Registration successful! You can now log in.'
      isRegistering.value = false
      password.value = ''
      confirmPassword.value = ''
    } else {
      const errorData = await response.text()
      message.value = `Registration failed: ${errorData || 'Please try again.'}`
    }
  } catch (error) {
    message.value = 'Error connecting to server.'
    console.error('Registration error:', error)
  }
}

const handleLogout = async () => {
  try {
    const response = await fetch('http://localhost:8080/api/logout', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      credentials: 'include' // Include cookies for session management
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

const handleDeleteAccount = async () => {
  if (confirm('Are you sure you want to delete your account? This action cannot be undone.')) {
    try {
      const response = await fetch('http://localhost:8080/api/delete_account', {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json'
        },
        credentials: 'include'
      });

      if (response.ok) {
        message.value = 'Account deleted successfully.';
        isLoggedIn.value = false;
        username.value = '';
        password.value = '';
      } else {
        message.value = 'Failed to delete account.';
      }
    } catch (error) {
      message.value = 'Error connecting to server.';
      console.error('Delete account error:', error);
    }
  }
};

const toggleMode = () => {
  isRegistering.value = !isRegistering.value
  message.value = ''
  password.value = ''
  confirmPassword.value = ''
}

// Check login status when component mounts
onMounted(() => {
  checkLoginStatus()
})
</script>

<template>
  <Content>
    <!-- Loading state -->
    <div v-if="isLoading">
      <p>Checking login status...</p>
    </div>

    <!-- Main content after loading -->
    <div v-else>
      <h2>{{ isLoggedIn ? 'Dashboard' : (isRegistering ? 'Register' : 'Login') }}</h2>

      <!-- Login Form -->
      <form v-if="!isLoggedIn && !isRegistering" @submit.prevent="handleLogin">
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

      <!-- Register Form -->
      <form v-if="!isLoggedIn && isRegistering" @submit.prevent="handleRegister">
        <div>
          <label for="reg-username">Username:</label>
          <input type="text" id="reg-username" v-model="username" required>
        </div>
        <div>
          <label for="reg-password">Password:</label>
          <input type="password" id="reg-password" v-model="password" required>
        </div>
        <div>
          <label for="confirm-password">Confirm Password:</label>
          <input type="password" id="confirm-password" v-model="confirmPassword" required>
        </div>
        <button type="submit">Register</button>
      </form>

      <!-- Toggle between Login and Register -->
      <div v-if="!isLoggedIn">
        <p>
          {{ isRegistering ? 'Already have an account?' : "Don't have an account?" }}
          <button type="button" @click="toggleMode">
            {{ isRegistering ? 'Login here' : 'Register here' }}
          </button>
        </p>
      </div>

      <!-- Dashboard -->
      <div v-if="isLoggedIn">
        <p>Welcome! You are logged in as {{ username }}.</p>
        <button @click="handleLogout">Logout</button>
        <button @click="handleDeleteAccount">Delete Account</button>
      </div>

      <!-- Message Display -->
      <div v-if="message">{{ message }}</div>
    </div>
  </Content>
</template>

<style scoped>
@import '../assets/typography-styles.css';

form {
  margin-bottom: 1rem;
}

form div {
  margin-bottom: 1rem;
}

label {
  display: block;
  margin-bottom: 0.25rem;
}

input {
  width: 100%;
  padding: 0.5rem;
  border: 1px solid #ccc;
  border-radius: 4px;
}

button {
  padding: 0.5rem 1rem;
  background-color: #F5BD16;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  margin-right: 0.5rem;
}

button:hover {
  background-color: #D99014;
}

button[type="button"] {
  background-color: transparent;
  color: #F5BD16;
  text-decoration: underline;
  padding: 0;
}

button[type="button"]:hover {
  background-color: transparent;
  color: #D99014;
}
</style>
