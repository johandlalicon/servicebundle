<template>
    <div class="gap-4 flex-col flex text-center">
        <div v-if="loading">Loading...</div>
        <div v-if="error">{{ error.message }}</div>
        <BaseInput v-model="serviceName" placeholder="Service Name" required />
        <textarea v-model="serviceDescription" placeholder="Enter Description"
            class="focus:ring-indigo-500 focus:border-indigo-500 block w-full pr-10 sm:text-sm border-gray-300 rounded-md py-2 px-4 border"
            required></textarea>
        <div>
            <label for="category">Select a category:</label>
            <select v-model="selectedCategory" id="category">
                <option value="" disabled>Select an option</option>
                <option v-for="category in categories" :key="category.id" :value="category.id">
                    {{ category.name }}
                </option>
            </select>
        </div>
        <div><label>Add A Photo: </label>
            <button @click.prevent="openUploadWidget" class="py-2 px-4 border border-gray-300 rounded-md bg-slate-200"
                :disabled="imageUploadDone">Upload</button>
            <div v-if="imageUploadDone">Image has been uploaded</div>
        </div>
        <div class="flex flex-col gap-6 items-center">
            <div class="flex flex-col items-center gap-4">
                <!-- <label>Opening Time</label>
                <input type="time" v-model="startTime" @input="adjustTime('startTime', $event)" />
                <label>Closing Time:</label>
                <input type="time" v-model="endTime" @input="adjustTime('endTime', $event)" /> -->

                <label>Opening Time</label>
                <VDatePicker v-model.string="startTime" mode="time" hide-time-header :timezone="timezone" />
                <label>Closing Time:</label>
                <VDatePicker v-model.string="endTime" mode="time" hide-time-header :timezone="timezone" />
            </div>
            {{ startTime.value }} {{ endTime.value }}
            <div class="flex gap-6">
                <label for="daysOfWeek"><strong>Available Days: </strong></label>
                <select id="daysOfWeek" v-model="selectedDays" multiple>
                    <option value="Sunday">Sunday</option>
                    <option value="Monday">Monday</option>
                    <option value="Tuesday">Tuesday</option>
                    <option value="Wednesday">Wednesday</option>
                    <option value="Thursday">Thursday</option>
                    <option value="Friday">Friday</option>
                    <option value="Saturday">Saturday</option>
                </select>
            </div>
            <div class="flex gap-4 items-center">
                <label for="price">Price:</label>
                <BaseInput v-model="servicePrice" step="0.01" placeholder="Enter price" required type="number" />

            </div>

            <div>
                <button @click.prevent="submitForm">Submit</button>
            </div>
        </div>
    </div>
</template>
  
<script setup>
import BaseInput from './BaseInput.vue';
import { ref } from 'vue';
import { useMutation } from "@vue/apollo-composable"
import AddServiceMutation from "../graphql/merchant/addService.mutation.gql"
import { useRouter } from 'vue-router';

const timezone = ref('Asia/Shanghai');
const router = useRouter();
const serviceName = ref(props.existingServiceData ? props.existingServiceData.name : '');
const serviceDescription = ref(props.existingServiceData ? props.existingServiceData.description : '');
const selectedCategory = ref(props.existingServiceData ? props.existingServiceData.category.id : 0);
const selectedDays = ref(props.existingServiceData ? props.existingServiceData.availableDays : []);
const image = ref(props.existingServiceData ? props.existingServiceData.imageUrl : '');
const servicePrice = ref(props.existingServiceData ? props.existingServiceData.price : '');
const startTime = ref(props.existingServiceData ? props.existingServiceData.openingTime : new Date());
const endTime = ref(props.existingServiceData ? props.existingServiceData.closingTime : new Date());

const imageUploadDone = ref(false)

const isLoading = ref(false);


const props = defineProps({
    categories: {
        type: Array
    },
    existingServiceData: {
        type: Object, // Change the type to match your service data structure
        default: null,
    }

})

const widget = cloudinary.createUploadWidget(
    { cloud_name: "dgks1y9qz", upload_preset: "waejp7di", sources: ['local'], autoClose: true, },
    (error, result) => {
        if (!error && result && result.event === "success") {
            image.value = result.info.secure_url;
            imageUploadDone.value = true
        }

    }
)

function openUploadWidget() {
    widget.open()
    console.log(props.existingServiceData.category.id)
}

const { mutate: addService, onDone, onError, error, loading } = useMutation(AddServiceMutation, () => ({
    variables: {
        name: serviceName.value,
        description: serviceDescription.value,
        opening_time: startTime.value,
        closing_time: endTime.value,
        available_days: selectedDays.value,
        price: parseFloat(servicePrice.value),
        image_url: image.value,
        category_id: selectedCategory.value,
        id: props.existingServiceData ? props.existingServiceData.id : ''
    },
}))

const submitForm = () => {
    const parsedPrice = parseFloat(servicePrice.value);

    // Check if parsedPrice is a valid number (not NaN)
    if (!isNaN(parsedPrice)) {
        // It's a valid number, proceed with addService
        addService();
    } else {
        // Handle the case where servicePrice is not a valid number
        console.error('Price is not a valid number');
        // You can display an error message or take other appropriate actions
    }
};

onDone(() => {
    router.go()
    console.log("Done?")
});

onError((error) => {
    console.log(error)
})





// const submitForm = () => {
//     if (!catName.value || !catDescription.value || !image.value) {
//         console.error('Fields must be filled.');
//         // You can display an error message to the user or perform other actions as needed.
//         return;
//     }

//     addCategory();
// };

</script>
  