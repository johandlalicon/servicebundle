import { defineStore } from "pinia";

export const useAuthStore = defineStore("auth", {
  state: () => ({
    authUser: null,
  }),
  getters: {
    user: (state) => state.authUser,
    isLoggedIn: (state) => state.authUser !== null,
  },
  actions: {
    setUser(user) {
      this.authUser = user;
    },
  },
});
