import { Controller } from 'stimulus';
import Rails from "@rails/ujs";

function getMetaValue(name) {
  const element = document.head.querySelector(`meta[name="${name}"]`)
  return element.getAttribute("content")
}

export default class extends Controller {
  connect() {
    if (this.data.get("next") == "false" && parseInt(this.data.get("count")) > 0) {
      let stimulus = this;
      let year = parseInt(this.data.get("year")) - 1

      stimulus.element.classList.add('loading')

      Rails.ajax({
        type: "get",
        datatType: "json",
        url: "/activities.json?year=" + year,
        success: function(data) {
          stimulus.data.set("next", "true")
          stimulus.element.classList.remove('loading')
          Rails.$("body")[0].innerHTML += data.html
        }
      });
    }
  }
}