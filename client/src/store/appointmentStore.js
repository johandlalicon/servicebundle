import { defineStore } from "pinia";

export const useAppointmentStore = defineStore("appointment", {
  state: () => ({
    selectedDate: null,
  }),
  mutations: {
    setSelectedDate(date) {
      this.selectedDate = date;
    },
    clearSelectedDate() {
      this.selectedDate = null;
    },
  },
});
