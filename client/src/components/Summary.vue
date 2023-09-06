<template>
    <div class="bg-indigo-200 rounded-lg overflow-hidden shadow-md hover:shadow-lg">
        <div class="flex flex-col justify-center text-center gap-4">
            <h2 class="text-2xl font-semibold">{{ serviceStore.serviceName }}</h2>
            <p class="text-gray-600">{{ serviceStore.description }}</p>
            <img :src="serviceStore.imageUrl" alt="Product Image" class="w-full h-48 object-cover mt-4" />
            <p class="text-green-600 font-semibold mt-4">${{ serviceStore.price.toFixed(2) }}</p>
            <p class="text-gray-700 mt-2">Appointment Date: {{ serviceStore.appointmentDate }}</p>
            <p class="text-gray-700 mt-2">First Name: {{ registrationStore.firstName }}</p>
            <p class="text-gray-700 mt-2">Last Name: {{ registrationStore.lastName }}</p>
            <p class="text-gray-700 mt-2">Email: {{ registrationStore.email }}</p>
            <p class="text-gray-700 mt-2">Mobile Number: {{ registrationStore.mobileNumber }}</p>
            <p class="text-gray-700 mt-2">Payment Method: {{ registrationStore.paymentMethod }}</p>
            <button @click="registerUser" class="bg-indigo-500 text-white py-2 px-4 rounded hover:bg-indigo-600">
                Book Now!
            </button>
            <button @click="handleCancel" class="py-2 px-4 rounded ">
                cancel
            </button>
        </div>

    </div>
</template>
<script setup props="props">
import { useRegistrationStore } from '../store/registration'; // Replace with your actual store path
import { useServiceStore } from '../store/serviceStore'; // Replace with your actual store path
import { defineEmits } from 'vue'

const serviceStore = useServiceStore()
const registrationStore = useRegistrationStore();

const emit = defineEmits()
const handleCancel = () => {
    emit('closeSummary')
}

</script>