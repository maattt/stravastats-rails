// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import 'controllers'


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('service-worker.js').then(function(reg) {
    console.log("registration succeeded")
  }).catch(function(error) {
    console.log("registration failed: " + error);
  })
}

window.addEventListener("DOMContentLoaded", (event) => {
  var ctx = document.getElementById('myChart');
  var myChart = new Chart(ctx, {
    type: 'line',
    data: {
      labels: ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin'],
      datasets: [{
        label: 'kilometers',
        data: [120, 89, 102, 133, 77, 29],
        borderColor: 'orange',
        borderWidth: 2,
        // borderJoinStyle: 'bevel',
        // borderCapStyle: 'square',
        fill: false
      }]
    },
    options: {
      responsive: true,
      scales: {
        xAxes: [{
          gridLines: {
            // color: "rgba(0, 0, 0, 0)"
          }
        }],
        yAxes: [{
          gridLines: {
            // color: "rgba(0, 0, 0, 0)"
          }   
        }]
      }
    }
  });
});