import { defineStore } from "pinia";

export const useRegistrationStore = defineStore("registration", {
  state: () => ({
    firstName: "",
    lastName: "",
    email: "",
    mobileNumber: "",
    paymentMethod: "",
  }),
  actions: {
    setFirstName(firstName) {
      this.firstName = firstName;
    },
    setLastName(lastName) {
      this.lastName = lastName;
    },
    setEmail(email) {
      this.email = email;
    },
    setMobileNumber(mobileNumber) {
      this.mobileNumber = mobileNumber;
    },
    setpaymentMethod(paymentMethod) {
      this.paymentMethod = paymentMethod;
    },
    clearRegistrationData() {
      this.firstName = "";
      this.lastName = "";
      this.email = "";
      this.mobileNumber = "";
    },
  },
});
