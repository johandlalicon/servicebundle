<template>
    <div class="bg-indigo-200 rounded-lg overflow-hidden shadow-md hover:shadow-lg">

        <div>
            <h1>PERSONAL INFORMATION</h1>
            <p v-if="error">{{ error }}</p>
            <div class="mb-4 flex flex-col gap-4">
                <div v-if="!isLoggedIn">
                    <span>If you already have an existing account </span><button @click="handleLogin">log in here</button>
                    <Login v-if="showLogin" />
                </div>

                <div v-if="isLoggedIn" class="flex flex-col">
                    <span>Confirmation email will be sent to: </span>
                    <strong>{{ authStore.user.email }}</strong>
                </div>
            </div>
            <div v-if="!isLoggedIn" class="mb-4">
                <BaseInput v-model="email" label="Email Address" type="email" />
            </div>
            <div class="mb-4">
                <BaseInput v-model="firstName" label="First Name" />
            </div>

            <div class="mb-4">
                <BaseInput v-model="lastName" label="Last Name" />
            </div>
            <div class="mb-4">
                <BaseInput v-model="mobileNumber" label="Mobile Number" type="number" />
            </div>
            <div class="mb-4">
                <BaseInput v-if="!isLoggedIn" v-model="password" label="Password" type="password" />
            </div>

            <div class="mb-4">
                <label for="paymentMethod" class="block text-gray-700 text-sm font-bold mb-2">Payment Method:</label>
                <select v-model="paymentMethod" id="paymentMethod" class="block w-full px-3 py-2 border rounded">
                    <option value="payInStore">Pay In Store</option>
                    <option value="bankPayment">Bank Payment</option>
                </select>
            </div>
            <div>
                <button v-if="isLoggedIn" @click="bookUser"
                    class="bg-indigo-500 text-white py-2 px-4 rounded hover:bg-indigo-600">
                    Continue
                </button>
                <button v-else @click="registerUser" class="bg-indigo-500 text-white py-2 px-4 rounded hover:bg-indigo-600">
                    Continue
                </button>
                <button @click="handleBack" class="py-2 px-4 rounded text-sm">
                    Back
                </button>

            </div>

        </div>

    </div>
</template>
  
<script setup>

import { ref, defineEmits, computed } from 'vue';
import BaseInput from './BaseInput.vue';
import { useRegistrationStore } from '../store/registration'
import { useMutation } from "@vue/apollo-composable"
import CreateUserMigration from "../graphql/createUser.mutation.gql"
import { useAuthStore } from '../store/auth';
import { useUserTypeStore } from "../store/userType";

import Login from "../components/Login.vue"

const authStore = useAuthStore();
const userTypeStore = useUserTypeStore();

const email = ref('');
const firstName = ref('');
const lastName = ref('');
const mobileNumber = ref('');
const paymentMethod = ref('');
const password = ref('')

const showLogin = ref(false)
const isLoggedIn = computed(() => authStore.user);
const emit = defineEmits();

const handleLogin = () => {
    showLogin.value = true
}


const registrationStore = useRegistrationStore(); // Initialize the store
const { mutate: createUser, onDone, onError, error, result } = useMutation(CreateUserMigration, () => ({
    variables: {
        email: email.value,
        password: password.value,
        first_name: firstName.value,
        last_name: lastName.value,
        mobile: mobileNumber.value
    }
}))
const registerUser = () => {

    createUser();
    console.log("register user")
}


const bookUser = () => {
    registrationStore.setFirstName(firstName.value);
    registrationStore.setLastName(lastName.value);
    registrationStore.setEmail(email.value ? email.value : authStore.user.email);
    registrationStore.setMobileNumber(mobileNumber.value);
    registrationStore.setpaymentMethod(paymentMethod.value);
    console.log('no created user')
    emit('getSummary')
}



onDone(result => {
    const userType = result.data.createUser.userType
    localStorage.setItem('token', result.data.createUser.token)
    const user = result.data.createUser.user;
    authStore.setUser(user)
    userTypeStore.setUserType(userType);
    registrationStore.setFirstName(firstName.value);
    registrationStore.setLastName(lastName.value);
    registrationStore.setEmail(email.value);
    registrationStore.setMobileNumber(mobileNumber.value);
    registrationStore.setpaymentMethod(paymentMethod.value);
    emit('getSummary')
    console.log(result)
})

const handleBack = () => {
    emit('cancelFillout')
}

</script>
  
  <!-- Your BaseInput component styles -->
<style scoped></style>