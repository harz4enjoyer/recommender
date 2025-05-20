<template>
  <div class="overFooter">
    <div class="footer">
      <div class="spacing color" @click="goTo('/Contact')"> Contact</div>
      <div class="spacing color" @click="goTo('/About')">About</div>
    </div>
    <div class="footerRight color spacing"> Anton Hellauer Conrad Klugist &#169</div>
  </div>
</template>

<script>
export default {
  methods: {
    goTo(path) {
      this.$router.push({ path: path })
    }
  }
}
</script>

<style scoped>
.footer {
  display: flex;
  flex-direction: row;
  position: absolute;
  bottom: 10px;
  left: 10px;
  font-size: 12px;
  color: rgba(255, 255, 255, 0.5);
  cursor: pointer;
  transition: 0.2s;
}

.footerRight {
  position: absolute;
  bottom: 10px;
  right: 5px;
  font-size: 12px;
  color: rgba(255, 255, 255, 0.5);
  transition: 0.2s;
}

.overFooter {
  position: fixed;
  bottom: 0;
  width: 100%;
  float: bottom;
  right: 5px;
  border-top: 1px solid #D99014;
  /* This line adds a continuous line */
  padding: 10px 0;
  /* Adjusts padding for the border-line */
}

.spacing {
  padding: 0 15px;
  /* Add padding on left and right for spacing */
  display: flex;
  align-items: center;
  /* Center content vertically in the spacing div */
}

.color {
  color: #D99014;
  background-color: #444;
  border-radius: 5px;
}
</style>
