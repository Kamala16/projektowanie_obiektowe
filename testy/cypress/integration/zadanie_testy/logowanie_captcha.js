describe('Logowanie_captcha', () => {
    it('Sprawdź poprawność hasła', () => {
        cy.visit('/login')

        cy.get('input.login-email')
          .type('ola@mail.pl')

        cy.get('input.login-password')
          .type('CzyPoprawne!23')

        cy.get('iframe')
            .first()
            .then((recaptchaIframe) => {
                const body = recaptchaIframe.contents()
                cy.wrap(body).find('.recaptcha-checkbox-border').should('be.visible').click()
        })

        cy.contains('Login')
          .click()
        
        cy.url()
          .should('include', '/home')
    })
  })