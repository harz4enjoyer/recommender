<template>
  <div :class="{ loader: true, fadeout: !isLoading }">
    <div class="pan-container">
      <span class="pan">🍳</span>
      <div class="loading-text">Cooking up something delicious...</div>
    </div>
  </div>
</template>

<script>
export default {
  name: "LoadingScreen",
  props: ["isLoading"]
};
</script>

<style>
.loader {
  bottom: 0;
  color: white;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 32px;
  left: 0;
  overflow: hidden;
  position: fixed;
  right: 0;
  text-align: center;
  top: 0;
  background-color: rgba(224, 163, 88, 0.6);
  /* Translucent background */
  backdrop-filter: blur(5px);
  /* Frosted glass effect */
}

.pan-container {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.pan {
  font-size: 100px;
  animation: spin 2s linear infinite;
}

@keyframes spin {
  0% {
    transform: rotate(0deg);
  }

  100% {
    transform: rotate(360deg);
  }
}

.loading-text {
  margin-top: 20px;
  font-size: 24px;
}

.fadeout {
  animation: fadeout 2s forwards;
}

@keyframes fadeout {
  to {
    opacity: 0;
    visibility: hidden;
  }
}
</style>
