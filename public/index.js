/* global Vue, VueRouter, axios */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      message: "Welcome to Vue.js!",
      products: [],
      productFilter: "",
      sortAttribute: "name",
      sortAscending: true
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
  methods: {
    isValidProduct: function(inputProduct) {
      return inputProduct.name
        .toLowerCase()
        .includes(this.productFilter.toLowerCase());
    },
    changeSortAttribute: function(inputAttribute) {
      this.sortAttribute = inputAttribute;
      this.sortAscending = !this.sortAscending;
    }
  },
  computed: {
    sortedProducts: function() {
      return this.products.sort(
        function(product1, product2) {
          if (this.sortAscending === true) {
            return product1[this.sortAttribute] > product2[this.sortAttribute];
          } else {
            return product1[this.sortAttribute] < product2[this.sortAttribute];
          }
        }.bind(this)
      );
    }
  }
};

var PeppersNew = {
  template: "#peppers-new-page",
  data: function() {
    return {
      name: "",
      price: "",
      description: "",
      species: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        price: this.price,
        description: this.description,
        species: this.species
      };
      axios
        .post("/v1/peppers", params)
        .then(function(response) {
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var PeppersUpdate = {
  template: "#peppers-update-page",
  data: function() {
    return {
      name: "",
      price: "",
      description: "",
      species: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        price: this.price,
        description: this.description,
        species: this.species
      };
      axios
        .post("/v1/peppers", params)
        .then(function(response) {
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var SignupPage = {
  template: "#signup-page",
  data: function() {
    return {
      name: "",
      email: "",
      password: "",
      passwordConfirmation: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        email: this.email,
        password: this.password,
        password_confirmation: this.passwordConfirmation
      };
      axios
        .post("/v1/users", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var LoginPage = {
  template: "#login-page",
  data: function() {
    return {
      email: "",
      password: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        auth: { email: this.email, password: this.password }
      };
      axios
        .post("/user_token", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  }
};

var LogoutPage = {
  mounted: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/peppers/new", component: PeppersNew },
    { path: "/peppers/update", component: PeppersUpdate },
    { path: "/signup", component: SignupPage },
    { path: "/login", component: LoginPage },
    { path: "/logout", component: LogoutPage }
  ]
});

var app = new Vue({
  el: "#app",
  router: router,
  mounted: function() {
    var jwt = localStorage.getItem("jwt");
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  }
});
