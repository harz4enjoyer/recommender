<script setup>
</script>

<template>

  <body>
    <main>
      <slot />
    </main>
  </body>
</template>
<style>
body {
  margin: 0;
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  font-family: Arial, sans-serif;
}

main {
  flex: 1;
  padding: 40px;
  /* Add padding for spacing */
  overflow-y: auto;
  /* Allow scrolling if content is too large */
}
</style>
