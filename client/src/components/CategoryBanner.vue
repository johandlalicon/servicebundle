<template>
    <div>
        <div class="bg-blue-500 text-white p-2 md:p-4 text-center hover:bg-blue-600 cursor-pointer"
            @click="handleCategoryClick">
            <h1 class="text-lg md:text-2xl font-bold">{{ name }}</h1>
        </div>
        <button @click="toggleEditForm">Edit</button>
        <div v-if="isEditFormVisible">
            <AddNewCat :existingCategoryData="existingCategoryData" />
        </div>
    </div>
</template>
<script setup>
import { ref } from 'vue';
import AddNewCat from './AddNewCat.vue';

const isEditFormVisible = ref(false);

const toggleEditForm = () => {
    isEditFormVisible.value = !isEditFormVisible.value;
    // console.log(category)
};

const emit = defineEmits();

const handleCategoryClick = (category) => {
    emit('categoryClick', category);
};

const props = defineProps({
    categoryId: {
        type: Number
    },
    name: {
        type: String
    },
    description: {
        type: String
    },
    existingCategoryData: {
        type: Object
    },
    categories: {
        type: Object
    }
})
</script>