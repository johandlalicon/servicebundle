<template>
    <h1>MERCHANT DASHBOARD</h1>
    <div class="mx-auto max-w-7xl px-2 sm:px-6 lg:px-8">
        <div class="relative flex h-16 items-center justify-between">
            <div class="flex flex-1 items-center justify-center ">
                <div class="flex space-x-4">
                    <!-- Current: "bg-gray-900 text-white", Default: "text-gray-300 hover:bg-gray-700 hover:text-white" -->
                    <a href="#"
                        class="text-gray-600 hover:bg-gray-700 hover:text-white rounded-md px-3 py-2 text-sm font-medium">All
                        Services</a>
                    <a href="#"
                        class="text-gray-600 hover:bg-gray-700 hover:text-white rounded-md px-3 py-2 text-sm font-medium">All
                        Category</a>

                    <router-link v-if="type === 'Merchant'" to="/merchant"
                        class="text-gray-300 hover:bg-gray-700 hover:text-white rounded-md px-3 py-2 text-sm font-medium">Merchant</router-link>
                </div>
            </div>
        </div>
    </div>


    <ServiceCard />
</template>
<script setup>
import ServiceCard from '../components/ServiceCard.vue';
</script>