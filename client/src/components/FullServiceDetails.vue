<template>
    <div class="bg-white rounded-lg overflow-hidden shadow-md hover:shadow-lg flex flex-col">
        <div class="aspect-h-1 aspect-w-1 overflow-hidden rounded-t-lg">
            <img :src="imageUrl" alt="Product Image" class="w-full h-48 object-cover" />
        </div>
        <div class="p-4 text-center">
            <h2 class="text-2xl font-semibold">{{ serviceName }}</h2>
            <p class="text-gray-600">{{ description }}</p>
            <p class="text-green-600 font-semibold mt-2">${{ price.toFixed(2) }}</p>
            <p class="text-gray-700 mt-2">
                Available on: {{ availableDays.join(', ') }}
            </p>
            <p class="text-gray-700 mt-2">Opening Time: {{ openingTime }}</p>
            <p class="text-gray-700 mt-2">Closing Time: {{ closingTime }}</p>
            <div class="mt-4">
                <label class="block text-gray-700 text-sm font-bold mb-2">Select Date & Time:</label>
                <!-- Add a date input field -->
                <VDatePicker v-model="date" mode="dateTime" :disabled-dates="disabledDates" :rules="rules" />
            </div>
            <div class="flex gap-4 justify-center pt-4">
                <button @click="bookService" class="border p-2">Book Service</button>
                <button @click="cancelPick" class="border p-2">Cancel</button>
            </div>
        </div>
    </div>
</template>
  
<script setup>
import { ref, defineEmits } from 'vue';
import { DateTime } from 'luxon';

import { useServiceStore } from '../store/serviceStore'; // Adjust the path as needed
const serviceStore = useServiceStore();


function convertTo24Hour(timeString) {
    // Use Luxon to parse the time string in 12-hour format
    const dateTime = DateTime.fromFormat(timeString, 'h:mm a');

    // Format it in 24-hour format (HH:mm)
    return dateTime.toFormat('HH:mm');
}

const storeOpeningTime = convertTo24Hour(props.openingTime);
const storeClosingTime = convertTo24Hour(props.closingTime);

const openingHour = parseInt(storeOpeningTime.split(':')[0], 10);
const closingHour = parseInt(storeClosingTime.split(':')[0], 10);

const allWeekdays = [1, 2, 3, 4, 5, 6, 7];
const disabledDays = props.availableDays.map((dayName) => {
    switch (dayName) {
        case "Sunday":
            return 1; // 1 corresponds to Sunday in v-calendar
        case "Monday":
            return 2; // 2 corresponds to Monday in v-calendar
        case "Tuesday":
            return 3; // 3 corresponds to Tuesday in v-calendar
        case "Wednesday":
            return 4; // 4 corresponds to Wednesday in v-calendar
        case "Thursday":
            return 5; // 5 corresponds to Thursday in v-calendar
        case "Friday":
            return 6; // 6 corresponds to Friday in v-calendar
        case "Saturday":
            return 7; // 7 corresponds to Saturday in v-calendar
        default:
            return null; // Invalid day name, handle as needed
    }
});

const availableWeekdays = allWeekdays.filter((weekday) => !disabledDays.includes(weekday));
const emit = defineEmits()
const date = ref(new Date())
const rules = ref({
    hours: { min: openingHour, max: (closingHour - 1) },
    minutes: { interval: 5 },
});
const disabledDates = ref(
    availableWeekdays.map((weekday) => ({
        repeat: {
            weekdays: [weekday],
        },
        highlight: true

    }))
);

const props = defineProps({
    serviceId: String,
    serviceName: String,
    description: String,
    imageUrl: String,
    price: Number,
    availableDays: Array,
    closingTime: String,
    openingTime: String,
});



// Function to book the service

const cancelPick = () => {
    emit('cancelPick')
}

const bookService = () => {
    serviceStore.setService({
        serviceId: props.serviceId,
        serviceName: props.serviceName,
        description: props.description,
        imageUrl: props.imageUrl,
        price: props.price,
        appointmentDate: date.value
    });
    emit('sendFilloutForm');
};

</script>
  