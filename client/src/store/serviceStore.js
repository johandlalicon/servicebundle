// stores/ServiceStore.js
import { defineStore } from "pinia";

export const useServiceStore = defineStore({
  id: "service",
  state: () => ({
    serviceId: "",
    serviceName: "",
    description: "",
    imageUrl: "",
    price: 0,
    appointmentDate: null, // Replace availableDays, closingTime, openingTime with appointmentDate
  }),
  actions: {
    setService({
      serviceId,
      serviceName,
      description,
      imageUrl,
      price,
      appointmentDate, // Modify the argument to include appointmentDate
    }) {
      this.serviceId = serviceId;
      this.serviceName = serviceName;
      this.description = description;
      this.imageUrl = imageUrl;
      this.price = price;
      this.appointmentDate = appointmentDate; // Store the appointment date
    },
  },
});
