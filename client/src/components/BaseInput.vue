<template>
    <div>

        <div class="mt-1 relative rounded-md shadow-sm"><input :value="modelValue"
                @input="$emit('update:modelValue', $event.target.value)" :placeholder="label" v-bind="$attrs" :type="type"
                class="focus:ring-indigo-500 focus:border-indigo-500 block w-full pr-10 sm:text-sm border-gray-300 rounded-md py-2 px-4 border" />
        </div>


    </div>
</template>

<script setup>
defineProps({
    modelValue: {
        type: [String, Number],
        default: ""
    },
    label: {
        type: String,
        default: ""
    },
    type: {
        type: String,
        default: "text"
    }
})

</script>

<style scoped></style>