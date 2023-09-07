<template>
    <div>
        <div v-if="loading">Loading...</div>
        <div v-if="error">{{ error.message }}</div>
        <h2 class="text-2xl font-semibold mb-4">All Booking History</h2>
        <div v-for="booking in bookings" :key="booking.id" class="space-y-6">
            <div v-if="!booking.upcoming" class="bg-white rounded-lg shadow-md p-4">

                <div class="flex justify-between items-center">
                    <div class="text-lg font-semibold">{{ booking.receipt }}</div>
                    <div class="text-green-600 font-semibold">
                        {{ determineStatus(booking.cancelled, booking.completed, booking.upcoming) }}
                    </div>
                </div>

                <div class="mt-2">
                    <div><strong>Booking Date:</strong> {{ formatDateTime(booking.createdAt) }}</div>
                    <div><strong>Name of Customer:</strong> {{ booking.user.firstName }} {{ booking.user.lastName }}</div>
                    <div><strong>Service & Service Provider:</strong> {{ booking.service.name }} |
                        {{ booking.merchant.name }}
                    </div>
                    <div><strong>Appointment Date:</strong> {{ formatDateTime(booking.appointmentDate) }}</div>
                    <div><strong>Amount:</strong> {{ booking.service.price }}</div>
                </div>
            </div>

            <div v-else-if="booking.upcoming" class="bg-white rounded-lg shadow-md p-4">
                <div class="flex justify-between items-center">
                    <div class="text-lg font-semibold">{{ booking.receipt }}</div>
                    <div v-if="!showUpdateStatus">
                        <div class="text-green-600 font-semibold">
                            {{ determineStatus(booking.cancelled, booking.completed, booking.upcoming) }}
                        </div>
                        <button @click="getBookingId(booking.id)">Update</button>
                    </div>
                    <div v-else>
                        <select v-model="selectedStatus">
                            <option value="completed">Completed</option>
                            <option value="cancelled">Cancelled</option>
                        </select>
                        <div class="flex gap-4 text-sm">
                            <button @click="handleUpdateStatus()">Submit</button>
                            <button @click="cancelUpdate">Cancel</button>
                        </div>
                    </div>
                </div>

                <div class="mt-2">

                    <div><strong>Booking Date:</strong> {{ formatDateTime(booking.createdAt) }}</div>
                    <div><strong>Name of Customer:</strong> {{ booking.user.firstName }} {{ booking.user.lastName }}
                    </div>
                    <div><strong>Service & Service Provider:</strong> {{ booking.service.name }} |
                        {{ booking.merchant.name }}
                    </div>
                    <div><strong>Appointment Date:</strong> {{ formatDateTime(booking.appointmentDate) }}</div>
                    <div><strong>Amount:</strong> {{ booking.service.price }}</div>
                </div>
            </div>
        </div>
    </div>
</template>
  
<script setup>
import { ref } from 'vue';
import BookingsQuery from '../../graphql/admin/bookings.query.gql'
import UpdateStatusMutation from '../../graphql/merchant/updateStatus.mutation.gql'
import { useQuery, useMutation } from '@vue/apollo-composable';
import { DateTime } from 'luxon';
const showUpdateStatus = ref(false);
const selectedStatus = ref('');
const bookingId = ref("");

const handleUpdateStatus = () => {
    updateStatus()
    showUpdateStatus.value = false;
};

const getBookingId = (newBookingId) => {
    bookingId.value = newBookingId;
    showUpdateStatus.value = true;
}

const cancelUpdate = () => {
    // Handle the logic to cancel the update
    showUpdateStatus.value = false;
};

const bookings = ref([]);
const users = ref([])

const { result, onResult, loading } = useQuery(BookingsQuery, {}, { fetchPolicy: "cache-first" });


const { mutate: updateStatus, onDone, onError, error } = useMutation(UpdateStatusMutation, () => ({
    variables: {
        id: bookingId.value,
        status: selectedStatus.value,
    },
}))

onDone((data) => {

    showUpdateStatus.value = false;
});


function formatDateTime(dateTimeString) {
    try {
        const dateTime = DateTime.fromISO(dateTimeString, { zone: 'utc' });
        return dateTime.toFormat('MMMM dd, yyyy, hh:mm:ss a');
    } catch (error) {
        console.error('Invalid date and time format:', error);
        return 'Invalid date and time';
    }
}

function determineStatus(cancelled, completed, upcoming) {
    if (cancelled) {
        return 'Cancelled';
    } else if (completed) {
        return 'Completed';
    } else if (upcoming) {
        return 'Upcoming';
    } else {
        return 'Unknown';
    }
}

onResult(({ data }) => {
    bookings.value = data?.allBookings || []

    console.log(data)

});

// Sample booking entries, replace with your actual data

// let status;
// function determineStatus(isTrue) {
//     if (isTrue) {
//         return;
//     } else if (isTrue) {
//         status = "Completed";
//     } else if (isTrue) {
//         status = "Upcoming";
//     }
// }
</script>
  
<style scoped>
/* Add your CSS styles for the table here */
</style>
  