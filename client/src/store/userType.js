import { defineStore } from "pinia";

export const useUserTypeStore = defineStore("userType", {
  state: () => ({
    userType: null,
  }),
  getters: {
    getUserType: (state) => state.userType,
  },
  actions: {
    setUserType(userType) {
      this.userType = userType;
    },
  },
});
