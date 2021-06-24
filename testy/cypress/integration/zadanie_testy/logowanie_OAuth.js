
describe('Auth0', function () {
    beforeEach(function () {
      cy.task('db:seed')
      cy.loginByAuth0Api(
        Cypress.env('auth_username'),
        Cypress.env('auth_password')
      )
    })
  
    it('shows onboarding', function () {
      cy.contains('Get Started').should('be.visible')
    })
  })
  

