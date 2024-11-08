import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["fileInput", "removeButton", "urlField"];

  connect() {
  }

  handleFileSelect(event) {
    const file = event.target.files[0];
    if (file) {
      this.removeButtonTarget.style.display = "block";
      this.urlFieldTarget.style.display = "none";
    }
  }

  removeFile() {
    this.fileInputTarget.value = "";
    this.removeButtonTarget.style.display = "none";
    this.urlFieldTarget.style.display = "block";
  }
}
