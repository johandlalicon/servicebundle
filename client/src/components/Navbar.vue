<script setup>

import Login from './Login.vue';
import { useAuthStore } from '../store/auth';
import { useUserTypeStore } from "../store/userType";
import { computed } from 'vue';

const userTypeStore = useUserTypeStore();
const authStore = useAuthStore();
const isLoggedIn = computed(() => authStore.isLoggedIn);
const user = computed(() => authStore.user);
const type = computed(() => userTypeStore.userType);

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
                <a href="#">Home</a>
                <a href="#">Services</a>

                <router-link v-if="type === 'Merchant'" to="/merchant">Merchant</router-link>
            </div>
            <div v-if="!isLoggedIn" class="justify-self-end">
                <Login />
            </div>
            <div v-else class="flex gap-4">
                <span>{{ type }}</span>
                <button @click="logout">Logout</button>

            </div>

        </div>
    </nav>
</template>
