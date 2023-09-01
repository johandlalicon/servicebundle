<script setup>

import Login from './Login.vue';
import { useAuthStore } from '../store/auth';
import { computed } from 'vue';
const authStore = useAuthStore();
const isLoggedIn = computed(() => authStore.isLoggedIn);
const user = computed(() => authStore.user);
const logout = () => {
    authStore.setUser(null);
    localStorage.removeItem("authUser");

    window.location.reload();
    window.location.href = "/";
};

</script>
<template>
    <nav class="bg-gray-200 p-4 shadow-lg gap-8">
        <div class="flex justify-between items-center">

            <div class="flex gap-4">
                <router-link to="/swipe">Home</router-link>
                <router-link to="/match">Services</router-link>
            </div>
            <div v-if="!isLoggedIn" class="justify-self-end">
                <Login />
            </div>
            <div v-else>
                <span>{{ user.id }}</span>
                <button @click="logout">Logout</button>

            </div>

        </div>
    </nav>
</template>
