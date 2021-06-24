describe('aukcja_pola', () => {
    it('Czy wypełniono pola', () => {
        cy.visit('/newAuction')

        cy.get('input.auction-name')
            .type('książka')

        cy.get('input.auction-description')
            .type('Ksiązka fantasy ....')

        cy.get('input.auction-amount')
            .type('1')

        cy.get('input.auction-price')
            .type('20')

        cy.get('input.auction-phone')
            .type('123546789')

        cy.contains('Dodaj')
            .click()

        cy.url()
            .should('include', '/newAuction')
    })
})