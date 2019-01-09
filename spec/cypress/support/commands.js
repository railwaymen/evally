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

Cypress.Commands.add('login', (email, password) => {
  let email_input = '.auth-form input[type="email"]'
  let password_input = '.auth-form input[type="password"]'
  let submit_btn = '.auth-form button[type="submit"]'

  cy.get(email_input)
    .type(email)
    .should('have.value', email)

  cy.get(password_input)
    .type(password)
    .should('have.value', password)

  cy.get(submit_btn).click()
})