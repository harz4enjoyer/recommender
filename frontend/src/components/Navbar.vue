<template>
  <nav class="navbar">
    <h1 class="center style">  Recommender System </h1>
    <ul>
      <li v-for="page in pages" :key="page">
        <div v-bind:class="{ 'nav-item': true, 'active': isActivePage(page) }" @click="goToPage(page)">
          <h2>{{ page }}</h2>
        </div>
        <div v-if="isActivePage(page)" class="arrow"></div>
      </li>
    </ul>
  </nav>
</template>



<script>
export default {
  name: 'NavigationBar',
  data() {
    return {
      pages: ['Home', 'Login']
    }
  },
  methods: {
    goToPage(page) {
      this.$router.push({ path: '/' + page })
    },
    isActivePage(page) {
      return page === this.$route.name
    }
  }
}
</script>



<style>
.navbar {
  background-color: #333;
  overflow: hidden;
  text-align: center;
}

.navbar ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  display: flex;
  /* Flexbox for horizontal alignment */
  justify-content: center;
  /* Center the items */
  gap: 20px;
  /* Add space between the items */
}

.navbar ul li {
  position: relative;
  /* Needed for the active state arrow positioning */
}

.navbar ul li .nav-item {
  padding: 2.5px 5px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.navbar ul li .nav-item:hover {
  background-color: #444;
}

.navbar ul li .active {
  font-weight: bold;
}

.navbar ul li .arrow {
  position: absolute;
  bottom: -5px;
  left: 50%;
  transform: translateX(-50%);
  width: 0;
  height: 0;
  border-left: 5px solid transparent;
  border-right: 5px solid transparent;
  border-top: 5px solid #fff;
  /* White arrow */
}

.navbar ul li .nav-item h2 {
  font-size: 18px;
  color: #D99014;
}

.navbar ul li .active h2 {
  color: #F53416;
}

.float {
  position: fixed;
  width: 100%;
  float: bottom;
  right: 5px;
}
</style>
