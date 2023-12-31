<template>
    <div class="mx-auto max-w-7xl px-2 sm:px-6 lg:px-8">
        <h1 class="text-xl font-extrabold">MERCHANT DASHBOARD FOR {{ merchantName }}</h1>
        <p v-if="loading">Loading...</p>
        <div class="relative flex h-16 items-center justify-between">
            <div class="flex flex-1 items-center justify-center ">
                <div class="flex space-x-4">
                    <button @click="showCard = 'ServiceList'"
                        :class="{ 'bg-gray-900 text-white': showCard === 'ServiceList', 'text-gray-600 hover:bg-gray-700 hover:text-white rounded-md px-3 py-2 text-sm font-medium': showCard !== 'ServiceCard' }"
                        class="text-gray-600 hover:bg-gray-700 hover:text-white rounded-md px-3 py-2 text-sm font-medium">
                        All Services
                    </button>

                    <button @click="showCard = 'CategoryBanner'"
                        :class="{ 'bg-gray-900 text-white': showCard === 'CategoryBanner', 'text-gray-600 hover:bg-gray-700 hover:text-white rounded-md px-3 py-2 text-sm font-medium': showCard !== 'CategoryBanner' }"
                        class="text-gray-600 hover:bg-gray-700 hover:text-white rounded-md px-3 py-2 text-sm font-medium">
                        All Category
                    </button>
                </div>
                <button @click="showCard = 'AllBookings'"
                    :class="{ 'bg-gray-900 text-white': showCard === 'AllBookings', 'text-gray-600 hover:bg-gray-700 hover:text-white rounded-md px-3 py-2 text-sm font-medium': showCard !== 'CategoryBanner' }"
                    class="text-gray-600 hover:bg-gray-700 hover:text-white rounded-md px-3 py-2 text-sm font-medium">
                    All Bookings
                </button>
            </div>

        </div>
    </div>
    <div>
        <div v-if="showCard === 'CategoryBanner'">
            <div class="flex flex-col text-xs gap-4">
                <div class="mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4 max-w-screen-lg">
                    <CategoryBanner v-for="category in categories" :key="category.id" :name="category.name"
                        @categoryClick="selectedCategory = category.services" :existingCategoryData="category" />
                </div>

                <div class="max-w-xs mx-auto text-center">
                    <button @click="toggleAddCategory" class="px-2 py-1 text-sm">Add
                        A Category</button>
                    <div v-if="!isAddCategoryButtonVisible" class="max-w-xs mx-auto ">
                        <AddNewCat />
                    </div>
                </div>

            </div>
        </div>
        <div v-else-if="showCard === 'ServiceList'">

            <div class="flex flex-col text-xs gap-4">

                <button @click="toggleAddService" class="px-2 py-1 text-sm">Add
                    A Service</button>
                <div v-if="!isAddServiceButtonVisible" class="max-w-xs mx-auto ">
                    <div class="max-w-xs mx-auto p-4 bg-white border border-gray-300 rounded-lg shadow-lg">
                        <AddNewService :categories="categories" />
                    </div>
                </div>

                <div class="mx-auto max-w-2xl px-4 py-16 sm:px-6 sm:py-24 lg:max-w-7xl lg:px-8">
                    <h1 v-if="highestBooking.bookingCount > 0">MOST BOOKED SERVICE</h1>
                    <div class="grid grid-cols-1 gap-x-6 gap-y-10 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 xl:gap-x-8">
                        <ServiceCard v-if="highestBooking.bookingCount > 0" :key="highestBooking.id"
                            :name="highestBooking.name" :image="highestBooking.imageUrl" :price="highestBooking.price" />
                        <ServiceCard v-for="service in services" :key="service.id" :name="service.name"
                            :image="service.imageUrl" :price="service.price" :servicesData="services"
                            :existingServiceData="service" :categories="categories" :bookCount="service.bookingCount" />
                    </div>
                </div>
            </div>

        </div>
        <div v-else-if="showCard === 'AllBookings'">

            <div class="mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4 max-w-screen-lg">
                <h1 v-if="merchantBookings.length === 0" class="text-xl font-extrabold">No bookings yet</h1>
                <MerchantAppointments v-for="booking in merchantBookings" :key="booking.id" :booking-id="booking.id"
                    :user="booking.user" :appointment-date="booking.appointmentDate" :service="booking.service"
                    :cancelled="booking.cancelled" :completed="booking.completed" :upcoming="booking.upcoming" />

            </div>

        </div>
    </div>

    <div v-if="showCard === 'CategoryBanner'" class="flex flex-col text-xs gap-4">
        <div class="mx-auto max-w-2xl px-4 py-16 sm:px-6 sm:py-24 lg:max-w-7xl lg:px-8">
            <div class="grid grid-cols-1 gap-x-6 gap-y-10 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 xl:gap-x-8">
                <ServiceCard v-for="service in selectedCategory" :key="service.id" :name="service.name"
                    :description="service.description" :price="service.price" :image="service.imageUrl" />
            </div>
        </div>
    </div>
</template>
  
<script setup>
import CategoryBanner from '../components/CategoryBanner.vue'
import ServiceCard from '../components/ServiceCard.vue';
import AddNewService from '../components/AddNewService.vue';
import AddNewCat from '../components/AddNewCat.vue';
import { useQuery } from "@vue/apollo-composable"
import GetMerchantQuery from '../graphql/merchant/findMerchant.query.gql'
import { ref } from 'vue';

import MerchantAppointments from '../components/Merchant/MerchantAppointments.vue';

const isAddCategoryButtonVisible = ref(true);
const isAddServiceButtonVisible = ref(true);
const showCard = ref("")
const categories = ref([])
const selectedCategory = ref([]);
const services = ref([]);
const merchantBookings = ref([]);
const highestBooking = ref({})
const merchantName = ref('')

function mostBooked(services) {
    return services.reduce((prev, current) =>
        prev.bookingCount > current.bookingCount ? prev : current
    );
}


const { result, onResult, loading } = useQuery(GetMerchantQuery, {}, { fetchPolicy: "cache-first" });

onResult(({ data }) => {
    console.log(data)
    merchantName.value = data?.findMerchant.name
    categories.value = data?.findMerchant?.categories || []
    services.value = data?.findMerchant?.services || []
    merchantBookings.value = data?.findMerchant?.bookings || []
    highestBooking.value = mostBooked(data.findMerchant.services)

});

const toggleAddCategory = () => {
    isAddCategoryButtonVisible.value = !isAddCategoryButtonVisible.value;
};

const toggleAddService = () => {
    isAddServiceButtonVisible.value = !isAddServiceButtonVisible.value;
};

</script>

<style></style>
  