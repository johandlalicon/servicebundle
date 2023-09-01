<template>
  <Navbar />
  <div class="m-10">
    <router-view></router-view>
  </div>
  <div>
    <button @click="openUploadWidget">Upload</button>
  </div>
</template>

<script setup>
import Navbar from './components/Navbar.vue';

const widget = cloudinary.createUploadWidget(
  { cloud_name: "dgks1y9qz", upload_preset: "waejp7di" },
  (err, result) => {
    if (!err && result && result.event === "success")
      console.log("Uploading done", result.info)
  }
)

function openUploadWidget() {
  widget.open();
}

</script>

<style scoped></style>
