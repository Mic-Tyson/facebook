import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reply-form"
export default class extends Controller {
  static targets = ["formContainer"]

  connect() {
    this.isVisible = false;
  }

  toggle(event) {
    event.preventDefault();

    this.hideAllFormContainers();

    this.isVisible = true;
    this.formContainerTarget.style.display = this.isVisible ? "block" : "none";

    if (this.isVisible) {
      const button = event.currentTarget;
      const buttonRect = button.getBoundingClientRect();
      this.formContainerTarget.style.top = `${buttonRect.top - 50}px`; 
      this.formContainerTarget.style.left = `${buttonRect.left}px`; 
      this.formContainerTarget.style.zIndex = 1000; 
    }
  }

  hideAllFormContainers() {
    const allFormContainers = document.querySelectorAll("[data-reply-form-target='formContainer']");
    allFormContainers.forEach(container => {
      container.style.display = "none";
    });
  }
}
