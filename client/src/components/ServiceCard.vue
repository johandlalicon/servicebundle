<template>
    <div class="group">
        <div class="aspect-h-1 aspect-w-1 w-full overflow-hidden rounded-lg bg-gray-200 xl:aspect-h-8 xl:aspect-w-7">
            <img :src="image" :alt="description" class="h-full w-full object-cover object-center group-hover:opacity-75"
                style="max-width: 100%; max-height: 100%;">
        </div>
        <h3 class="mt-4 text-sm text-gray-700">{{ name }}</h3>
        <p class="mt-1 text-lg font-medium text-gray-900">${{ price }}</p>
        <p class="text-sm italic font-light">{{ description }}</p>
        <div v-if="type === 'Merchant'">
            <button @click="toggleEditForm">Edit</button>
            <div v-if="isEditFormVisible">
                <AddNewService :editedname="name" :existingServiceData="existingServiceData" :categories="categories" />
            </div>
        </div>
    </div>
</template>

<script setup>

import { ref, computed } from 'vue';
import AddNewService from './AddNewService.vue';
import { useUserTypeStore } from "../store/userType";



const userTypeStore = useUserTypeStore();
const type = computed(() => userTypeStore.userType);

const isEditFormVisible = ref(false);

const toggleEditForm = () => {
    isEditFormVisible.value = !isEditFormVisible.value;
};

const prop = defineProps({
    name: {
        type: String
    },
    description: {
        type: String
    },
    id: {
        type: Number
    },
    price: {
        type: Number
    },

    openingTime: {
        type: String
    },
    closingTime: {
        type: String
    },
    availableDays: {
        type: Array
    },
    image: {
        type: String
    },
    existingServiceData: {
        type: Object
    },
    categories: {
        type: Array
    }
})


</script>