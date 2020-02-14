describe('Login view', function() {
  it('visit login view', function() {
    cy.visit('/')

    cy.contains('Sign in')
  })

  it('get error on invalid credentials', function() {
    cy.visit('/')

    cy.get('[data-cy=login-email]')
      .find('input')
      .type('fake@example.com')
      .should('have.value', 'fake@example.com')

    cy.get('[data-cy=login-password]')
      .find('input')
      .type('password')
      .should('have.value', 'password')

    cy.get('[data-cy="login-submit"]').find('button').click()

    cy.contains('Invalid credentials, please try again.')
  })
})
