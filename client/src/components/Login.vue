
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
import { useUserTypeStore } from "../store/userType";
import { ref } from 'vue'
import BaseInput from './BaseInput.vue';
import { useMutation } from "@vue/apollo-composable"
import SignInMutation from "../graphql/userSignIn.mutation.gql"
import { useRouter } from "vue-router";

const router = useRouter();
const authStore = useAuthStore();
const userTypeStore = useUserTypeStore();
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

    const userType = result.data.signInUser.userType
    console.log(userType)
    localStorage.setItem('token', result.data.signInUser.token)
    if (result.data.signInUser.userType === "User") {
        const user = result.data.signInUser.user;
        authStore.setUser(user)
        userTypeStore.setUserType(userType);
        router.push("/user")
    } else if (result.data.signInUser.userType === "Merchant") {
        const merchant = result.data.signInUser.merchant;

        authStore.setUser(merchant)
        userTypeStore.setUserType(userType);
        router.push("/merchant")
    }
    else if (result.data.signInUser.userType === "Admin") {
        const user = result.data.signInUser.user;
        authStore.setUser(user)
        userTypeStore.setUserType(userType);
        router.push("/admin")
    }

})

// onDone(result => {
//     console.log(result.data.signInUser.token)
//     localStorage.setItem('token', result.data.signInUser.token)
//     const user = result.data.signInUser.user;
//     const merchant = result.data.signInUser.merchant;
//     if (user) {
//         console.log(user)
//         authStore.setUser(user)

//     } else {
//         console.log(merchant)
//         authStore.setUser(merchant)

//     }

// })

</script>