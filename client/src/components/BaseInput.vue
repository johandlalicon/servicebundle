<template>
    <div>
        <label for="">{{ label }}
            <input :value="modelValue" @input="$emit('update:modelValue', $event.target.value)" :placeholder="label"
                v-bind="$attrs" :type="type" class="rounded px-2 " />
        </label>
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