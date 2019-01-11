context('Employees', () => {
  before(() => {
    cy.exec('RAILS_ENV=cypress rails db:schema:load db:seed')
    cy.loginUI('admin@example.com', 'password')

    cy.get('[data-cy="tab-employees"]').click()
  })

  beforeEach(() => {
    cy.loginAPI('admin@example.com', 'password')
  })

  describe('Employee creation', () => {
    it('expects to return errors if form is empty', () => {
      cy.openEmployeeForm()

      cy.get('[data-cy="employee-submit"]').click()
      cy.contains('This field is required.')

      cy.get('[data-cy="employee-cancel"]').click()
      cy.get('[data-cy="employee-form"]').should('not.be.visible')
    })

    it('expects create employee successfully', () => {
      let employee = {
        first_name: 'Jan',
        last_name: 'Kowalski',
        position: 'Web Developer',
        hired_at: '2019-01-11'
      }

      cy.reload()

      cy.openEmployeeForm()

      cy.get('[data-cy="employee-first_name"]')
        .type(employee.first_name)
        .should('have.value', employee.first_name)

      cy.get('[data-cy="employee-last_name"]')
        .type(employee.last_name)
        .should('have.value', employee.last_name)

      cy.get('[data-cy="employee-position"]')
        .type(employee.position + '{enter}')

      cy.get('[data-cy="employee-hired_at"]').click()
      cy.get('.v-picker--date').should('be.visible')
      cy.get('.v-picker--date').find('.v-btn--outline').click()

      cy.get('[data-cy="employee-submit"]').click()
      cy.checkFlash('Employee has been succefully created.')

      
    })
  })
})