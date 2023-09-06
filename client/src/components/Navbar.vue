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
    localStorage.removeItem("userType");

    window.location.reload();
    window.location.href = "/";
};

</script>
<template>
    <nav class="bg-gray-800">
        <div class="mx-auto max-w-7xl px-2 sm:px-6 lg:px-8">
            <div class="relative flex h-16 items-center justify-between">
                <div class="flex flex-1 items-center justify-center sm:items-stretch sm:justify-start">

                    <div class="flex space-x-4">
                        <!-- Current: "bg-gray-900 text-white", Default: "text-gray-300 hover:bg-gray-700 hover:text-white" -->
                        <a href="#" class="bg-gray-900 text-white rounded-md px-3 py-2 text-sm font-medium"
                            aria-current="page">Dashboard</a>
                        <router-link to="/marketplace"
                            class="text-gray-300 hover:bg-gray-700 hover:text-white rounded-md px-3 py-2 text-sm font-medium">Marketplace</router-link>


                        <router-link v-if="type === 'Merchant'" to="/merchant"
                            class="text-gray-300 hover:bg-gray-700 hover:text-white rounded-md px-3 py-2 text-sm font-medium">Merchant</router-link>
                    </div>

                </div>
                <div class="absolute inset-y-0 right-0 flex items-center pr-2 sm:static sm:inset-auto sm:ml-6 sm:pr-0">

                    <div v-if="!isLoggedIn" class="justify-self-end">
                        <Login />
                    </div>
                    <div v-else class="flex gap-4">
                        <button @click="logout" class="py-2 px-4 text-sm bg-sky-500 text-white">Logout</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Mobile menu, show/hide based on menu state. -->

    </nav>
</template>
<!-- <nav class="bg-gray-200">
    <div class="mx-auto max-w-7xl px-2 sm:px-6 lg:px-8">

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
</nav> -->