describe('Logowanie_hasło', () => {
    it('Sprawdź poprawność hasła', () => {
        cy.visit('/login')

        cy.get('input.login-email')
          .type('ola@mail.pl')

        cy.get('input.login-password')
          .type('CzyPoprawne!23')

        cy.contains('Login')
          .click()
        
        cy.url()
          .should('include', '/home')
    })
  })
  