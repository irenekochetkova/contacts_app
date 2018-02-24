/* global Vue, VueRouter, axios */



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
        .post("/users", params)
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
          console.log(response.data.jwt);
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
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var ContactsIndexPage = {
  template: "#contact-index-page",
  data: function() {
    return {
      contacts: []
    };
  },
  created: function() {
    axios.get("http://localhost:3000/contacts").then(function(response) {

      this.contacts = response.data; //array or recipe data
      console.log(response.data);

    }.bind(this));
  },
  // methods: {
  //   setCurrentContact: function(contact) {
  //     this.currentContact = contact;
  //     console.log(this.currentContact);
  //   }
  // }
};

var ContactsNewPage = {
  template: "#contacts-new-page",
  data: function() {
    return {
      first_name: "",
      middle_name: "",
      last_name: "",
      email: "",
      phone_number: "",
      bio: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        first_name: this.first_name,
        middle_name: this.middle_name,
        last_name: this.last_name,
        email: this.email,
        phone_number: this.phone_number,
        bio: this.bio
      };
      axios
        .post("/contacts", params)
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


var router = new VueRouter({
  routes: [
   { path: "/", component: ContactsIndexPage },
   { path: "/signup", component: SignupPage },
   { path: "/login", component: LoginPage },
   { path: "/logout", component: LogoutPage },
   { path: "/contacts/new", component: ContactsNewPage }

  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router,
  created: function() {
    var jwt = localStorage.getItem("jwt");
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  }
});