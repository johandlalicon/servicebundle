<template>
  <div class="rounded-lg overflow-hidden shadow-md hover:shadow-lg">
    <div class="flex flex-col justify-center text-center gap-4">
      <p class="text-2xl" v-if="completed">Booking has been completed!</p>
      <p class="text-2xl" v-else>Booking is pending or canceled.</p>

      <p class="text-lg" v-if="completed">Receipt Number:{{ props.bookingData.receipt }} </p>

      <button class="bg-blue-500 text-white px-4 py-2 rounded mt-4 hover:bg-blue-600" @click="viewBooking">
        <router-link to="/userbookings">View Booking</router-link>
      </button>
      <router-link to="/">Back To Marketplace</router-link>

    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, defineEmits } from 'vue';

const props = defineProps({
  bookingData: {
    type: Object
  }
})

const completed = ref(false);
const receiptNumber = ref('');
const emit = defineEmits();


const viewBooking = () => {
  // Handle the logic to view the booking
  // For example, navigate to a booking details page
};

// Simulate a delay (e.g., fetching data) to change the booking status and get a receipt number
onMounted(() => {
  setTimeout(() => {
    completed.value = true; // Set to true to show completion message
    console.log(props.bookingData)
    receiptNumber.value = '12345'; // Replace with the actual receipt number
  }, 2000); // Simulated 2-second delay
});
</script>

<style scoped>
/* Add custom styles here if needed */
</style>