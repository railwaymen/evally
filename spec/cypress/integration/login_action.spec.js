context('Login action', () => {
  beforeEach(() => {
    cy.exec('RAILS_ENV=cypress rails db:schema:load db:seed')
    cy.visit('/')
  })

  describe('Page loading', () => {
    it('expects to load page succesfully', () => {
      cy.contains('Sign in')

      cy.get('.auth-form__logo').find('img').should('have.attr', 'alt', 'Logo Evally') 
    })

    it('expects to redirect back if unauthorized', () => {
      cy.visit('/app')
      cy.url().should('eq', Cypress.config().baseUrl + '/')

      cy.contains('You are not authorized to perform this action. Please log in.')
    })
  })

  describe('Action form', () => {
    it('expects to return invalid credentials message', () => {
      cy.login('fake@example.com', 'password')
      cy.contains('Invalid credentials, please try again.')
    })

    it('expects to log in succesfully', () => {
      cy.login('admin@example.com', 'password')
      cy.url().should('include', '/app/start')

      cy.contains('Hello John!')
      cy.contains('You have been logged in succesfully.')
    })

  })

})