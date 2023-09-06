<template>
    <div class="mx-auto max-w-2xl px-4 py-16 sm:px-6 sm:py-24 lg:max-w-7xl lg:px-8">
        <div class="grid grid-cols-1 gap-x-6 gap-y-10 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 xl:gap-x-8">
            <ServiceCard v-for="service in services" :key="service.id" :name="service.name" :image="service.imageUrl"
                :price="service.price" :servicesData="services" :existingServiceData="service"
                @click="emitServiceData(service)" />
        </div>
    </div>
</template>
<script setup>
import ServiceCard from './ServiceCard.vue';
import AllServicesQuery from '../graphql/allServices.query.gql'
import { useQuery } from "@vue/apollo-composable"
import { ref } from 'vue';
import { defineEmits } from 'vue';

const emit = defineEmits();
const services = ref([]);
const userSelect = ref({})

const { result, onResult, loading } = useQuery(AllServicesQuery, {}, { fetchPolicy: "cache-first" });

const emitServiceData = (service) => {
    userSelect.value = service;
    emit('serviceClicked', userSelect.value);
};


onResult(({ data }) => {
    services.value = data?.allServices || []
});

// :categories="categories"

</script>