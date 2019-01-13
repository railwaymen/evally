context('Employees', () => {
  let baseListLength

  before(() => {
    cy.exec('RAILS_ENV=cypress rails db:schema:load db:seed')
    cy.loginUI('admin@example.com', 'password')

    cy.get('[data-cy="tab-employees"]').click()

    cy.get('[data-cy="employee-list-item"]').then($elems => {
      baseListLength = $elems.length
    })
  })

  beforeEach(() => {
    cy.loginAPI('admin@example.com', 'password')
  })

  describe('Employees search sidebar', () => {
    it('expects to hide sidebar', () => {
      cy.get('[data-cy="btn-sidebar-toggle"]').click()
      cy.get('[data-cy="employees-list"]').should('not.be.visible')
    })

    it('expects to show sidebar', () => {
      cy.get('[data-cy="btn-sidebar-toggle"]').click()
      cy.get('[data-cy="employees-list"]').should('be.visible')
    })

    it('expects to have 3 employees', () => {
      cy.get('[data-cy="employee-list-item"]').should('have.length', baseListLength)
    })

    it('expects to filter employees on type', () => {
      cy.get('[data-cy="employees-search"]').type('Smith')
      cy.get('[data-cy="employee-list-item"]').should('have.length', 1)
    })

    it('expects to show no employees message', () => {
      cy.get('[data-cy="employees-search"]').type(' Roger')
      cy.get('[data-cy="employee-list-item"]').should('have.length', 0)

      cy.get('[data-cy="employees-list"]').contains('There are no employees')
    })

    it('expects to remove filter', () => {
      cy.get('[data-cy="employees-search"]').clear()
      cy.get('[data-cy="employee-list-item"]').should('have.length', baseListLength)
    })
  })

  describe('Employee create action', () => {
    beforeEach(() => {
      cy.reload()
      cy.get('[data-cy="btn-new"]').click()
    })

    it('expects to return error if form is invalid', () => {
      cy.submitEmployee({ first_name: null, last_name: 'Nowak' }, 'create')
      cy.get('[data-cy="employee-form"]').contains('This field is required.')
    })

    it('expects to create employee successfully', () => {
      cy.submitEmployee({ first_name: 'Piotr', last_name: 'Nowak' }, 'create')
      cy.checkFlash('Employee has been succefully created.')

      cy.get('[data-cy="employee-list-item"]').should('have.length', baseListLength + 1)
    })

    it('expects to have just created employee after reload', () => {

      cy.get('[data-cy="employee-list-item"]').should('have.length', baseListLength + 1)
    })
  })

  describe('Employee edit action', () => {
    beforeEach(() => {
      cy.reload()

      cy.get('[data-cy="employee-list-item"]').first().click()
      cy.get('[data-cy="btn-edit"]').should('be.visible').click()

      cy.get('[data-cy="employee-last_name"]').clear()
    })

    it('expects to return error if update failure', () => {
      cy.submitEmployee({ }, 'edit')
      cy.get('[data-cy="employee-form"]').contains('This field is required.')

      cy.get('[data-cy="employee-list-item"]').should('have.length', baseListLength + 1)
    })

    it('expects to edit employee\'s last name', () => {
      cy.submitEmployee({ last_name: 'Adams' }, 'edit')
      cy.checkFlash('Employee has been succefully updated.')

      cy.get('[data-cy="employees-search"]').type('Adams')
      cy.get('[data-cy="employee-list-item"]').should('have.length', 1)
    })
  })

  describe('Employee permalink action', () => {
    beforeEach(() => {
      cy.reload()

      cy.get('[data-cy="employee-list-item"]').first().click()
      cy.get('[data-cy="btn-permalink"]').should('be.visible').click()
    })

    it('expects to show permalink dialog', () => {
      cy.get('[data-cy="permalink-dialog"]').should('be.visible').contains(`${ window.location.origin }/browse`)

      cy.get('[data-cy="permalink-dialog"]').find('[data-cy="btn-copy"]').click()
      cy.get('[data-cy="permalink-dialog"]').should('be.visible')

      cy.checkFlash('Permalink has been copied to clipboard.')
    })
  })

  describe('Employee delete action', () => {
    beforeEach(() => {
      cy.reload()

      cy.get('[data-cy="employee-list-item"]').first().click()
      cy.get('[data-cy="btn-remove"]').should('be.visible').click()
    })

    it('expect to close dialog if canceled', () => {
      cy.get('[data-cy="delete-modal"]').should('be.visible').find('[data-cy="btn-cancel"]').click()

      cy.get('[data-cy="delete-modal"]').should('not.be.visible')
      cy.get('[data-cy="employee-list-item"]').should('have.length', baseListLength + 1)
    })

    it('expect to remove first employee', () => {
      cy.get('[data-cy="delete-modal"]').should('be.visible').find('[data-cy="btn-delete"]').click()

      cy.checkFlash('Employee has been succefully deleted.')
      cy.get('[data-cy="employee-list-item"]').should('have.length', baseListLength)

      cy.get('[data-cy="evaluation-box"]').contains('Select employee to see his latest evaluation.')

      cy.get('[data-cy="employees-search"]').type('Adams')
      cy.get('[data-cy="employee-list-item"]').should('have.length', 0)

      cy.get('[data-cy="employees-search"]').clear()
    })
  })

  describe('Employee archive action', () => {
    it('expects to move employee to archive', () => {
      cy.reload()

      cy.get('[data-cy="employee-list-item"]').last().click()

      cy.get('[data-cy="btn-archive"]')
        .should('be.visible').click()

      cy.get('[data-cy="archive-modal"]')
        .should('be.visible')

      cy.get('[data-cy="archive-modal"]').find('[data-cy="btn-submit"]')
        .should('be.disabled')

      cy.get('[data-cy="archive-modal"]').find('[data-cy="radio-experienced"]').check({ force: true })

      cy.get('[data-cy="archive-modal"]').find('[data-cy="btn-submit"]')
        .should('not.be.disabled').click()

      cy.checkFlash('Employee has been succefully archived.')

      cy.get('[data-cy="employee-list-item"]').should('have.length', baseListLength - 1)

      cy.get('[data-cy="evaluation-box"]').contains('Select employee to see his latest evaluation.')
    })
  })
})