import { createApp, provide, h } from "vue";
import "./style.css";
import "./index.css";

import App from "./App.vue";
import router from "./router";
import { setContext } from "@apollo/client/link/context";
import { createPinia } from "pinia";
import { useAuthStore } from "../src/store/auth";
import VCalendar from "v-calendar";
import "v-calendar/style.css";

import {
  ApolloClient,
  createHttpLink,
  InMemoryCache,
} from "@apollo/client/core";

import { DefaultApolloClient } from "@vue/apollo-composable";

const pinia = createPinia();

const httpLink = createHttpLink({
  // uri: "http://localhost:3000/graphql",
  uri: "https://eeaao.onrender.com/graphql",
});

const authLink = setContext((_, { headers }) => {
  const token = localStorage.getItem("token");
  return {
    headers: {
      ...headers,
      Authorization: token ? `Bearer ${token}` : "",
    },
  };
});

const cache = new InMemoryCache();

const apolloClient = new ApolloClient({
  link: authLink.concat(httpLink),
  cache,
});

const app = createApp({
  setup() {
    provide(DefaultApolloClient, apolloClient);
  },

  render: () => h(App),
});
app.use(router);
app.use(VCalendar, {});
app.use(pinia);
// app.use(useAuthStore);
app.mount("#app");
