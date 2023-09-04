<template>
  <Navbar />
  <div class="m-10">
    <router-view></router-view>
  </div>
</template>

<script setup>
import Navbar from './components/Navbar.vue';


import { onMounted, watch } from "vue";
import { computed } from 'vue';
import { useAuthStore } from './store/auth';
import { useUserTypeStore } from "./store/userType";

const authStore = useAuthStore();
const userTypeStore = useUserTypeStore();

const user = computed(() => authStore.user);
const isLoggedIn = computed(() => authStore.isLoggedIn);


// const { result } = useQuery(ListMatchQuery);
// console.log(result)

watch(
  () => authStore.user,
  (newUser) => {
    if (newUser) {
      localStorage.setItem("authUser", JSON.stringify(newUser));
    } else {
      localStorage.removeItem("authUser");
    }
  }
);

watch(
  () => userTypeStore.userType,
  (newUsertype) => {
    if (newUsertype) {
      localStorage.setItem("userType", JSON.stringify(newUsertype));
    } else {
      localStorage.removeItem("userType");
    }
  }
);


onMounted(() => {
  const storedUser = localStorage.getItem("authUser");
  if (storedUser) {
    authStore.setUser(JSON.parse(storedUser));
  }
});

onMounted(() => {
  const storedUserType = localStorage.getItem("userType");
  if (storedUserType) {
    userTypeStore.setUserType(JSON.parse(storedUserType));
  }
});




</script>

<style scoped></style>
