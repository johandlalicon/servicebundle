import HomePage from "../views/HomePage.vue";
import MerchantPage from "../views/MerchantPage.vue";
import MarketplacePage from "../views/MarketplacePage.vue";
import UserBookingsPage from "../views/UserBookingsPage.vue";
import AdminPage from "../views/AdminPage.vue";
import { createRouter, createWebHistory } from "vue-router";

const routes = [
  {
    path: "/",
    name: "home",
    component: HomePage,
  },
  {
    path: "/merchant",
    name: "merchant",
    component: MerchantPage,
  },
  {
    path: "/marketplace",
    name: "marketplace",
    component: MarketplacePage,
  },
  {
    path: "/userbookings",
    name: "bookings",
    component: UserBookingsPage,
  },
  {
    path: "/admin",
    name: "admin",
    component: AdminPage,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
