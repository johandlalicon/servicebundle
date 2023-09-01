<template>
  <Navbar />
  <div class="mt-10">
    <router-view></router-view>
  </div>
</template>
<script setup>
import Navbar from './components/Navbar.vue';
</script>

<style scoped></style>
