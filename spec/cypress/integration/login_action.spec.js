context('Login action', () => {
  beforeEach(() => {
    cy.exec('RAILS_ENV=cypress rails db:schema:load db:seed')
    cy.visit('/')
  })

  describe('Page loading', () => {
    it('expects to load page succesfully', () => {
      cy.contains('Sign in')

      cy.get('[data-cy=evally_logo]').find('img').should('have.attr', 'alt', 'Logo Evally') 
    })

    it('expects to redirect back if unauthorized', () => {
      cy.visit('/app')
      cy.url().should('eq', Cypress.config().baseUrl + '/')

      cy.contains('You are not authorized to perform this action. Please log in.')
    })
  })

  describe('Action form', () => {
    it('expects to return invalid credentials message', () => {
      cy.loginUI('fake@example.com', 'password')
      cy.contains('Invalid credentials, please try again.')
    })

    it('expects to log in succesfully', () => {
      cy.loginUI('admin@example.com', 'password')
      cy.contains('You have been logged in succesfully.')
    })

  })

})