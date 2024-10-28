import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "form", 
    "submitButton", 
    "description", 
    "suggestedPriority", 
    "selectedPriority",
    "formContainer",
    "loadingState"
  ]

  connect() {
    this.isSubmitting = false
  }

  showLoading() {
    this.formContainerTarget.classList.add('animate-fade-out')
    setTimeout(() => {
      this.formContainerTarget.classList.add('hidden')
      this.loadingStateTarget.classList.remove('hidden')
      this.loadingStateTarget.classList.add('animate-fade-in')
    }, 300)
  }

  hideLoading() {
    this.loadingStateTarget.classList.add('animate-fade-out')
    setTimeout(() => {
      this.loadingStateTarget.classList.add('hidden')
      this.formContainerTarget.classList.remove('hidden')
      this.formContainerTarget.classList.add('animate-fade-in')
    }, 300)
  }

  async checkPriority(event) {
    event.preventDefault()
    
    if (this.isSubmitting) return

    this.isSubmitting = true
    this.submitButtonTarget.disabled = true
    this.showLoading()

    try {
      const formData = new FormData(this.formTarget)
      const response = await fetch(this.formTarget.action, {
        method: 'POST',
        headers: {
          'Accept': 'application/json',
          'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
        },
        body: formData
      })
      
      if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`)
      const data = await response.json()
      
      this.hideLoading()
      if (data.suggested_priority) {
        this.showPriorityModal(data.suggested_priority)
      } else {
        this.showErrorModal()
      }
    } catch (error) {
      console.error('Error:', error)
      this.hideLoading()
      this.showErrorModal()
    }
  }

  showPriorityModal(suggestedPriority) {
    const currentPriority = this.selectedPriorityTarget.value
    if (suggestedPriority !== currentPriority) {
      this.suggestedPriorityTarget.value = suggestedPriority
      const modal = document.createElement('div')
      modal.innerHTML = `
        <div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity"></div>
        <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
          <div class="flex min-h-full items-end justify-center p-4 text-center sm:items-center sm:p-0">
            <div class="relative transform overflow-hidden rounded-lg bg-white px-4 pb-4 pt-5 text-left shadow-xl transition-all sm:my-8 sm:w-full sm:max-w-lg sm:p-6">
              <div class="sm:flex sm:items-start">
                <div class="mx-auto flex h-12 w-12 flex-shrink-0 items-center justify-center rounded-full bg-blue-100 sm:mx-0 sm:h-10 sm:w-10">
                  <svg class="h-6 w-6 text-blue-600" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9.879 7.519c1.171-1.025 3.071-1.025 4.242 0 1.172 1.025 1.172 2.687 0 3.712-.203.179-.43.326-.67.442-.745.361-1.45.999-1.45 1.827v.75M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-9 5.25h.008v.008H12v-.008z" />
                  </svg>
                </div>
                <div class="mt-3 text-center sm:ml-4 sm:mt-0 sm:text-left">
                  <h3 class="text-base font-semibold leading-6 text-gray-900">Priority Suggestion</h3>
                  <div class="mt-2">
                    <p class="text-sm text-gray-500">
                      The AI suggests this incident should be priority ${suggestedPriority}. 
                      Would you like to use this priority instead?
                    </p>
                  </div>
                </div>
              </div>
              <div class="mt-5 sm:mt-4 sm:flex sm:flex-row-reverse">
                <button type="button" class="inline-flex w-full justify-center rounded-md bg-blue-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-blue-500 sm:ml-3 sm:w-auto" data-action="click->priority-modal#acceptSuggestion">
                  Use Suggested Priority
                </button>
                <button type="button" class="mt-3 inline-flex w-full justify-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 sm:mt-0 sm:w-auto" data-action="click->priority-modal#keepOriginal">
                  Keep Original Priority
                </button>
              </div>
            </div>
          </div>
        </div>
      `
      document.body.appendChild(modal)
      this.modalTarget = modal
    } else {
      this.submitForm()
    }
  }

  acceptSuggestion() {
    this.selectedPriorityTarget.value = this.suggestedPriorityTarget.value
    this.closeModal()
    this.submitForm()
  }

  keepOriginal() {
    this.closeModal()
    this.submitForm()
  }

  closeModal() {
    if (this.modalTarget) {
      this.modalTarget.remove()
    }
  }

  async submitForm() {
    const formData = new FormData(this.formTarget)
    try {
      const response = await fetch('/incidents/save_incident', {
        method: 'POST',
        headers: {
          'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
        },
        body: formData
      })
      
      if (response.redirected) {
        window.location.href = response.url
      }
    } catch (error) {
      console.error('Error:', error)
    }
  }

  showErrorModal() {
    const modal = document.createElement('div')
    modal.innerHTML = `
      <div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity"></div>
      <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
        <div class="flex min-h-full items-end justify-center p-4 text-center sm:items-center sm:p-0">
          <div class="relative transform overflow-hidden rounded-lg bg-white px-4 pb-4 pt-5 text-left shadow-xl transition-all sm:my-8 sm:w-full sm:max-w-lg sm:p-6">
            <div class="sm:flex sm:items-start">
              <div class="mx-auto flex h-12 w-12 flex-shrink-0 items-center justify-center rounded-full bg-red-100 sm:mx-0 sm:h-10 sm:w-10">
                <svg class="h-6 w-6 text-red-600" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z" />
                </svg>
              </div>
              <div class="mt-3 text-center sm:ml-4 sm:mt-0 sm:text-left">
                <h3 class="text-base font-semibold leading-6 text-gray-900">Error Processing Request</h3>
                <div class="mt-2">
                  <p class="text-sm text-gray-500">
                    We couldn't process the priority suggestion. Would you like to proceed with your selected priority?
                  </p>
                </div>
              </div>
            </div>
            <div class="mt-5 sm:mt-4 sm:flex sm:flex-row-reverse">
              <button type="button" class="inline-flex w-full justify-center rounded-md bg-blue-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-blue-500 sm:ml-3 sm:w-auto" data-action="click->priority-modal#submitForm">
                Continue Anyway
              </button>
              <button type="button" class="mt-3 inline-flex w-full justify-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 sm:mt-0 sm:w-auto" data-action="click->priority-modal#resetForm">
                Try Again
              </button>
            </div>
          </div>
        </div>
      </div>
    `
    document.body.appendChild(modal)
    this.modalTarget = modal
  }

  resetForm() {
    this.closeModal()
    this.isSubmitting = false
    this.submitButtonTarget.disabled = false
    this.formContainerTarget.classList.remove('hidden')
    this.loadingStateTarget.classList.add('hidden')
  }
} 