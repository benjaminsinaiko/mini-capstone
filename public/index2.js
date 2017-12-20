/* global axios */
axios.get("http://localhost:3000/v1/peppers").then(function(response) {
  var products = response.data;
  console.log(products);

  var template = document.querySelector("#product-card");
  var productContainer = document.querySelector(".row");

  products.forEach(function(product) {
    // productContainer.appendChild(template.content.cloneNode(true));
    var clone = template.content.cloneNode(true);

    clone.querySelector(".card-title").innerText = product.name;
    clone.querySelector(".card-text").innerText = product.description;
    clone.querySelector(".card-img-top").src = product.images[0]["images"];

    productContainer.appendChild(clone);
  });
});

