<template>
    <div class="bg-blue-500 text-white p-2 md:p-4 text-center hover:bg-blue-600 cursor-pointer"
        @click="handleCategoryClick">
        <h1 class="text-lg md:text-2xl font-bold">{{ name }}</h1>
    </div>

    <!-- Add more banners here -->
</template>
<script setup>

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
})
</script>