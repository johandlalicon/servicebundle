import HomePage from "../views/HomePage.vue";
import MerchantPage from "../views/MerchantPage.vue";
import MarketplacePage from "../views/MarketplacePage.vue";
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
    name: "user",
    component: MarketplacePage,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
