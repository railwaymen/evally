context('Layout', () => {
  before(() => {
    cy.exec('RAILS_ENV=cypress rails db:schema:load db:seed')
    cy.loginUI('admin@example.com', 'password')
  })

  beforeEach(() => {
    cy.loginAPI('admin@example.com', 'password')
  })

  describe('Main navigation', () => {
    it('expects to open dashboard after login', () => {
      cy.url().should('include', '/app/start')
      cy.get('.panel').find('.panel__heading').should('have.text', 'Hello John!')
    })

    it('expects to contain initials and fullname in profile btn', () => {
      cy.get('[data-cy="profile-initials"]').should('have.text', 'JD')
      cy.get('[data-cy="profile-fullname"]').should('have.text', 'John Doe')
    })

    it('expects to open evaluations page', () => {
      cy.get('[data-cy="tab-evaluations"]').click()

      cy.url().should('include', '/app/evaluations')
      cy.get('.panel').find('.panel__heading').should('have.text', 'Evaluations')
    })

    it('expects to open employees page', () => {
      cy.get('[data-cy="tab-employees"]').click()

      cy.url().should('include', '/app/employees')
      cy.get('.panel').find('.panel__heading').should('have.text', 'Employees')
    })

    it('expects to open templates page', () => {
      cy.get('[data-cy="tab-templates"]').click()

      cy.url().should('include', '/app/templates')
      cy.get('.panel').find('.panel__heading').should('have.text', 'Templates')
    })

    it('expects to open archive page', () => {
      cy.get('[data-cy="tab-archive"]').click()

      cy.url().should('include', '/app/archive')
      cy.get('.panel').find('.panel__heading').should('have.text', 'Archive')
    })

    it('expects to open settings page', () => {
      cy.get('[data-cy="profile-btn"]').click()
      cy.get('[data-cy="profile-menu"]').should('be.visible')

      cy.get('[data-cy="li-settings"]').click()
      cy.url().should('include', '/app/settings/general')
      cy.get('.panel').find('.panel__heading').should('have.text', 'Settings')
    })

    it('expects to open dashboard page', () => {
      cy.get('[data-cy="tab-dashboard"]').click()
      cy.url().should('include', '/app/start')
    })

    it('expects to log out successfully', () => {
      cy.get('[data-cy="profile-btn"]').click()
      cy.get('[data-cy="profile-menu"]').should('be.visible')

      cy.get('[data-cy="li-logout"]').click()
      cy.url().should('eq', Cypress.config().baseUrl + '/')
      cy.contains('You have been logged out succesfully')
    })
  })
})