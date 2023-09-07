<template>
    <div>
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
                    <div><strong>Service & Service Provider:</strong> {{ booking.service.name }} |
                        {{ booking.merchant.name }}
                    </div>
                    <div><strong>Appointment Date:</strong> {{ formatDateTime(booking.appointmentDate) }}</div>
                    <div><strong>Amount:</strong> {{ booking.service.price }}</div>
                </div>
            </div>
            <div v-else>

                <h2 class="text-2xl font-semibold mb-4">Upcoming Bookings</h2>
                <div class="flex justify-between items-center">
                    <div class="text-lg font-semibold">{{ booking.receipt }}</div>
                    <div>
                        <div class="text-green-600 font-semibold">
                            {{ determineStatus(booking.cancelled, booking.completed, booking.upcoming) }}
                        </div>
                    </div>

                </div>
                <div class="mt-2">
                    <div><strong>Booking Date:</strong> {{ formatDateTime(booking.createdAt) }}</div>
                    <div><strong>Service & Service Provider:</strong> {{ booking.service.name }} |
                        {{ booking.merchant.name }}
                    </div>
                    <div><strong>Appointment Date:</strong> {{ formatDateTime(booking.appointmentDate) }}</div>
                    <div><strong>Amount:</strong> {{ booking.service.price }}</div>
                </div>
            </div>
        </div>
        <h1 v-if="totalUpcoming.length === 0" class=" text-2xl font-semibold mb-4">NO Upcoming Bookings</h1>
    </div>
</template>
  
<script setup>
import { ref, computed } from 'vue';
import { useQuery } from "@vue/apollo-composable"
import UserBookingsQuery from '../graphql/userBookings.query.gql'
import { DateTime } from 'luxon';

const bookings = ref([]);
const totalUpcoming = ref({})
// const upcomingBookings = bookings.filter(booking => booking.upcoming);

const { result, onResult, loading } = useQuery(UserBookingsQuery, {}, { fetchPolicy: "cache-first" });
function formatDateTime(dateTimeString) {
    try {
        const dateTime = DateTime.fromISO(dateTimeString, { zone: 'utc' });
        return dateTime.toFormat('MMMM dd, yyyy, hh:mm:ss a');
    } catch (error) {
        console.error('Invalid date and time format:', error);
        return 'Invalid date and time';
    }
}

onResult(({ data }) => {
    bookings.value = data.userBookings

    console.log(data.userBookings)
    totalUpcoming.value = data.userBookings.filter(booking => booking.upcoming);


});


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



onResult((result) => {
    console.log(result)
})
const appointments = ref([
    { id: 1, name: 'Appointment 1', date: '2023-09-10', status: 'upcoming' },
    { id: 2, name: 'Appointment 2', date: '2023-08-15', status: 'completed' },
    { id: 3, name: 'Appointment 3', date: '2023-07-20', status: 'canceled' },
]);

// Filter appointments based on status
const upcomingAppointments = computed(() => appointments.value.filter(appointment => appointment.status === 'upcoming'));
const completedAppointments = computed(() => appointments.value.filter(appointment => appointment.status === 'completed'));
const canceledAppointments = computed(() => appointments.value.filter(appointment => appointment.status === 'canceled'));
</script>
  
<style scoped>
/* Add custom styles here if needed */
</style>
  