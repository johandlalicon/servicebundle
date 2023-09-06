<template>
    <div class="gap-4 flex-col flex text-center">
        <BaseInput v-model="catName" placeholder="Category Name" required />
        <textarea v-model="catDescription" placeholder="Enter Description"
            class="focus:ring-indigo-500 focus:border-indigo-500 block w-full pr-10 sm:text-sm border-gray-300 rounded-md py-2 px-4 border"
            required></textarea>
        <div><span>Add A Photo: </span>
            <button @click.prevent="openUploadWidget"
                class="py-2 px-4 border border-gray-300 rounded-md bg-slate-200">Upload</button>
            <div ref="uploadWidget"></div>
        </div>
        <div>
            <button @click.prevent="submitForm">Submit</button>
        </div>

        <div v-if="error">{{ error }}</div>
    </div>
</template>
  
<script setup>
import BaseInput from './BaseInput.vue';
import { ref } from 'vue';
import { useMutation } from "@vue/apollo-composable"
import AddCategory from "../graphql/merchant/addCategory.mutation.gql"


const catName = ref(props.existingCategoryData ? props.existingCategoryData.name : '');;
const catDescription = ref(props.existingCategoryData ? props.existingCategoryData.description : '');
const image = ref(props.existingCategoryData ? props.existingCategoryData.imageUrl : '');

const props = defineProps({
    existingCategoryData: {
        type: Object
    },
})


const { mutate: addCategory, onDone, onError, error, result } = useMutation(AddCategory, () => ({
    variables: {
        name: catName.value,
        description: catDescription.value,
        image_url: image.value,
        id: props.existingCategoryData ? props.existingCategoryData.id : ""
    },

}))


const widget = cloudinary.createUploadWidget(
    { cloud_name: "dgks1y9qz", upload_preset: "waejp7di", sources: ['local'] },
    (error, result) => {
        if (!error && result && result.event === "success") {
            console.log("Done uploading...")
            image.value = result.info.secure_url;
        }

    }
)

function openUploadWidget() {
    widget.open()
    console.log(props.existingCategoryData.name)
}

const submitForm = () => {
    if (!catName.value || !catDescription.value) {
        console.error('Fields must be filled.');
        // You can display an error message to the user or perform other actions as needed.
        return;
    }

    addCategory();
};

onDone(() => {
    window.location.reload();
});


</script>
  