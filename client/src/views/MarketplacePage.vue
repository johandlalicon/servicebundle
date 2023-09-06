<template>
    <FullServiceDetails v-if="showUserPick" class="overlay" :key="userPick.id" :serviceName="userPick.name"
        :description="userPick.description" :price="userPick.price" :availableDays="userPick.availableDays"
        :imageUrl="userPick.imageUrl" :closingTime="formatTime(userPick.closingTime)" :serviceId="userPick.id"
        :openingTime="formatTime(userPick.openingTime)" @sendFilloutForm="handleRegister" @cancelPick="closeUserPick" />
    <RegisterUser v-if="showFillout" class="overlay" @cancelFillout="closeFillout" @getSummary="openSummary" />
    <Summary v-if="showSummary" class="overlay" @closeSummary="closeSummary" />

    <div class="mx-auto max-w-7xl px-2 sm:px-6 lg:px-8 border-b pb-4">
        <h1 class="text-xl font-extrabold">VIEW ALL SERVICE OR CHOOSE PREFERRED MERCHANT</h1>
        <div class="relative flex h-16 items-center justify-between">
            <div class="flex flex-1 items-center justify-center ">
                <div class="flex space-x-4">
                    <button @click="showCard = 'ServiceList'"
                        :class="{ 'bg-gray-900 text-white': showCard === 'ServiceList', 'text-gray-600 hover:bg-gray-700 hover:text-white rounded-md px-3 py-2 text-sm font-medium': showCard !== 'ServiceCard' }"
                        class="text-gray-600 hover:bg-gray-700 hover:text-white rounded-md px-3 py-2 text-sm font-medium">
                        View Services
                    </button>

                    <button @click="showCard = 'MerchantList'"
                        :class="{ 'bg-gray-900 text-white': showCard === 'CategoryBanner', 'text-gray-600 hover:bg-gray-700 hover:text-white rounded-md px-3 py-2 text-sm font-medium': showCard !== 'CategoryBanner' }"
                        class="text-gray-600 hover:bg-gray-700 hover:text-white rounded-md px-3 py-2 text-sm font-medium">
                        View By Merchant
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div>
        <ServiceList v-if="showCard === 'ServiceList'" @serviceClicked="handleServiceClick" />
    </div>
    <div v-if="showCard === 'MerchantList'">
        <div class="mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4 max-w-screen-lg">
            <div v-for="merchant in merchants" @click="handleMerchantClick(merchant)">
                <div class=" p-2 md:p-4 text-center hover:bg-blue-600 cursor-pointer border pb-4">
                    <h1 class="text-lg md:text-2xl font-bold">{{ merchant.name }}</h1>
                </div>
            </div>
        </div>
        <div v-if="selectedMerchantCategory">
            <div class="text-center my-4">
                <h1 class="font-bold">Categories For: {{ selectedMerchant.name }}</h1>
            </div>
            <div class="mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4 max-w-screen-lg">

                <div v-for="category in selectedMerchantCategory" @click=" handleCategoryClick(category)">
                    <div class=" p-2 md:p-4 text-center ">
                        <h1 class="md:text-2xl font-bold">{{ category.name }}</h1>
                    </div>
                </div>
            </div>
        </div>
        <div v-if="selectedCategoryServices" class="mx-auto max-w-2xl px-4 py-16 sm:px-6 sm:py-24 lg:max-w-7xl lg:px-8">
            <div class="grid grid-cols-1 gap-x-6 gap-y-10 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 xl:gap-x-8">
                <ServiceCard v-for="service in selectedCategoryServices" :key="service.id" :name="service.name"
                    :image="service.imageUrl" :price="service.price" />
            </div>
        </div>
    </div>
</template>
<script setup>
import { ref } from 'vue';
import { useQuery } from "@vue/apollo-composable"
import AllMerchantQuery from '../graphql/allMerchant.query.gql'

import ServiceList from '../components/ServiceList.vue';
import ServiceCard from '../components/ServiceCard.vue'
import FullServiceDetails from '../components/FullServiceDetails.vue';
import RegisterUser from '../components/RegisterUser.vue';
import Summary from '../components/Summary.vue';
import { DateTime } from 'luxon';

const showCard = ref("")
const merchants = ref([]);
const selectedMerchant = ref({})
const selectedMerchantCategory = ref([])
const selectedCategoryServices = ref([])

const showUserPick = ref(false)
const showFillout = ref(false)
const showSummary = ref(false)
const userPick = ref({})


function formatTime(timeString) {
    // Parse the time string using Luxon
    const dateTime = DateTime.fromISO(timeString, { zone: 'utc' });

    // Convert the time to UTC (zero offset)
    const formattedTime = dateTime.setZone('Etc/UTC').toFormat('h:mm a');

    // Log the formatted time
    console.log(formattedTime);

    return formattedTime;
}

const handleRegister = () => {
    showUserPick.value = false
    showFillout.value = true

};

const closeUserPick = () => {
    showUserPick.value = false
}

const closeFillout = () => {
    showFillout.value = false
}

const openSummary = () => {
    showSummary.value = true
    if (showFillout || showUserPick) {
        showFillout.value = false
        showUserPick.value = false
    }

}

const closeSummary = () => {
    showSummary.value = false
}

const handleServiceClick = (selectedService) => {

    console.log('Service clicked:', selectedService);
    userPick.value = selectedService
    showUserPick.value = true
};
const handleMerchantClick = (merchant) => {
    selectedMerchant.value = merchant
    selectedMerchantCategory.value = merchant.categories
}

const handleCategoryClick = (category) => {
    if (category.services.length > 0) {
        selectedCategoryServices.value = category.services
    };

}

const { result, onResult, loading } = useQuery(AllMerchantQuery, {}, { fetchPolicy: "cache-first" });

onResult(({ data }) => {
    console.log(data.allMerchants)
    merchants.value = data?.allMerchants || []
});

</script>

<style>
.overlay {
    position: fixed;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: white;
    /* Set the background color to white */
    z-index: 999;
    display: flex;
    justify-content: center;
    align-items: center;
}
</style>

    