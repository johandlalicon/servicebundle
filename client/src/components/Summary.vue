<template>
    <div class="bg-indigo-200 rounded-lg overflow-hidden shadow-md hover:shadow-lg">
        <div v-if="!successComponent" class="flex flex-col justify-center text-center gap-4">
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
            <button @click="bookUser" class="bg-indigo-500 text-white py-2 px-4 rounded hover:bg-indigo-600">
                Book Now!
            </button>
            <button @click="handleCancel" class="py-2 px-4 rounded ">
                cancel
            </button>
        </div>
        <div v-else="successComponent">
            <SuccessBooking :booking-data="bookingData" />
        </div>

    </div>
</template>
<script setup>
import { useRegistrationStore } from '../store/registration'; // Replace with your actual store path
import { useServiceStore } from '../store/serviceStore'; // Replace with your actual store path
import { defineEmits, ref } from 'vue'
import { useMutation } from "@vue/apollo-composable"
import CreateBookingMutation from "../graphql/createBooking.mutation.gql"
import SuccessBooking from './SuccessBooking.vue';

const serviceStore = useServiceStore()
const registrationStore = useRegistrationStore();

const { mutate: createBooking, onDone, onError, error, result } = useMutation(CreateBookingMutation, () => ({
    variables: {
        serviceId: serviceStore.serviceId,
        appointmentDate: serviceStore.appointmentDate
    }
}))

const successComponent = ref(false)
const bookingData = ref({})

const emit = defineEmits()

const handleCancel = () => {
    emit('closeSummary')
}

const bookUser = () => {
    createBooking();
}
async function processResult(result) {
    if (result.data?.createBooking) {
        // Assuming bookingData.value is a ref or reactive data
        bookingData.value = await result.data.createBooking.booking;

    }
    ;
}


onDone(async (result) => {
    await processResult(result);
    successComponent.value = true
    console.log(typeof bookingData.value.receipt)
});

</script>