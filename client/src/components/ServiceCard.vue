<template>
    <a href="#" class="group">
        <div class="aspect-h-1 aspect-w-1 w-full overflow-hidden rounded-lg bg-gray-200 xl:aspect-h-8 xl:aspect-w-7">
            <img src="https://res.cloudinary.com/dgks1y9qz/image/upload/v1693587449/service-bundle/fuei3ywpqyc9wojyhubf.png"
                alt="{{ description }}" class="h-full w-full object-cover object-center group-hover:opacity-75">
        </div>
        <h3 class="mt-4 text-sm text-gray-700">{{ name }}</h3>
        <p class="mt-1 text-lg font-medium text-gray-900">${{ price }}</p>
        <p class="text-sm italic font-light">{{ description }}</p>
    </a>
</template>

<script setup>
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
    }
})
</script>