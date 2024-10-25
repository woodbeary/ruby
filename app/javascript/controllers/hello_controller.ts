import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["output"]
  declare readonly outputTarget: HTMLElement

  connect() {
    this.outputTarget.textContent = "Hello from TypeScript!"
  }
}
