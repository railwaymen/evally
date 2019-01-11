// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************
//
//
// -- This is a parent command --
// Cypress.Commands.add("login", (email, password) => { ... })
//
//
// -- This is a child command --
// Cypress.Commands.add("drag", { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add("dismiss", { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This is will overwrite an existing command --
// Cypress.Commands.overwrite("visit", (originalFn, url, options) => { ... })

Cypress.Commands.add('loginUI', (email, password) => {
  cy.visit('/')

  cy.get('[data-cy="email"]')
    .find('input')
    .type(email)
    .should('have.value', email)

    cy.get('[data-cy="password"]')
    .find('input')
    .type(password)
    .should('have.value', password)

    cy.get('[data-cy="submit"]').find('button').click()
})

Cypress.Commands.add('loginAPI', (email, password) => {
  cy.request({
    method: 'POST',
    url: '/en/v1/session',
    body: {
      email: email,
      password: password,
    }
  })
  .then((resp) => {
    window.localStorage.setItem('ev411y_t0k3n', resp.body.session.jwt)
  })

})

Cypress.Commands.add('openEmployeeForm', () => {
  cy.url().should('include', '/app/employees')

  cy.get('[data-cy="btn-new"]').click()
  cy.get('[data-cy="employee-form"]').should('be.visible')
})

Cypress.Commands.add('checkFlash', (message) => {
  cy.get('[data-cy="flash"]').should('be.visible').contains(message)
})

