
<template>
    <div class="flex gap-4 items-center">
        <p v-if="error" class="p-4">{{ error.message }}</p>
        <BaseInput v-model="userEmail" type="email" placeholder="Email" />
        <BaseInput v-model="userPassword" type="password" placeholder="Password" />
        <button @click="login" class="py-2 px-4 text-sm bg-sky-500 text-white">Login</button>
    </div>
</template>


<script setup>
import { useAuthStore } from '../store/auth';
import { ref } from 'vue'
import BaseInput from './BaseInput.vue';
import { useMutation } from "@vue/apollo-composable"
import SignInMutation from "../graphql/userSignIn.mutation.gql"

const authStore = useAuthStore();

const { mutate: signInUser, onDone, onError, error, result } = useMutation(SignInMutation, () => ({
    variables: {
        email: userEmail.value,
        password: userPassword.value,
    }
}))

const userEmail = ref('')
const userPassword = ref('')

function login() {
    signInUser()
}

onDone(result => {
    const user = result.data.signInUser.user;
    if (user) {
        console.log(user)
        authStore.setUser(user)
        localStorage.setItem('token', result.data.signInUser.token)

    }

})

</script>