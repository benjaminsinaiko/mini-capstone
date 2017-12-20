/* global Vue, VueRouter, axios */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      message: "Welcome to Vue.js!",
      products: []
    };
  },
  mounted: function() {
    axios.get("http://localhost:3000/v1/peppers").then(
      function(response) {
        this.products = response.data;
        console.log(this.products);
      }.bind(this)
    );
  },
  methods: {},
  computed: {}
};

var router = new VueRouter({
  routes: [{ path: "/", component: HomePage }]
});

var app = new Vue({
  el: "#app",
  router: router
});
