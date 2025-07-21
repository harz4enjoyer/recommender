import { createRouter, createWebHistory } from "vue-router";
import HomeView from "../views/HomeView.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/Home",
      name: "Home",
      component: HomeView,
    },
    { path: "/", redirect: "/Login" },
    {
      path: "/About",
      name: "About",
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import("../views/AboutView.vue"),
    },
    {
      path: "/Contact",
      name: "Contact",
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import("../views/ContactView.vue"),
    },
    {
      path: "/Login",
      name: "Login",
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import("../views/LoginView.vue"),
    },
  ],
});

router.beforeEach(async (to, from, next) => {
  const response = await fetch("/api/login_status");
  const data = await response.json();
  const isLoggedIn = data.username != null;

  if (to.name !== 'Login' && !isLoggedIn) {
    next({ name: 'Login' });
  } else {
    next();
  }
});

export default router;
