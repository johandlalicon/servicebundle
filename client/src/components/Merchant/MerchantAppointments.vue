<template>
    <div class="appointment-card">
        <div class="user">
            <strong>Booked by:</strong> {{ props.user.firstName }} {{ props.user.lastName }}
        </div>
        <div class="service">
            <strong>Service:</strong> {{ props.service.name }}
        </div>
        <div class="date">
            <strong>Date:</strong> {{ props.appointmentDate }}
        </div>
        <div class="status">
            <div>
                <div v-if="!showUpdateStatus">
                    <strong>Status:</strong> {{ status }}
                    <button @click="getBookingId(props.bookingId)">Update</button>
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
        </div>
    </div>
</template>
  
<script setup>
import { ref } from 'vue';
import { useMutation, useQuery } from '@vue/apollo-composable';

import UpdateStatusMutation from '../../graphql/merchant/updateStatus.mutation.gql'
import findMerchant from '../../graphql/merchant/findMerchant.query.gql'

const { mutate: updateStatus, onDone, onError, error, result } = useMutation(UpdateStatusMutation, () => ({
    variables: {
        id: bookingId.value,
        status: selectedStatus.value,
    },
}))

onDone((data) => {
    // console.log(data)
    status = selectedStatus; // Adjust this line to match your actual data structure
    showUpdateStatus.value = false;
});

const bookingId = ref("");

const showUpdateStatus = ref(false);
const selectedStatus = ref('');
// const status = 'Your Status'; // Replace with your actual status data

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


const props = defineProps({
    appointmentDate: {
        type: String
    },
    service: {
        type: Object
    },
    user: {
        type: Object
    },
    cancelled: {
        type: Boolean
    },
    completed: {
        type: Boolean
    },
    upcoming: {
        type: Boolean
    },
    services: {
        type: Array
    },
    bookingId: {
        type: String
    }

})

let status;

if (props.cancelled) {
    status = "Cancelled";
} else if (props.completed) {
    status = "Completed";
} else if (props.upcoming) {
    status = "Upcoming";
}
</script>