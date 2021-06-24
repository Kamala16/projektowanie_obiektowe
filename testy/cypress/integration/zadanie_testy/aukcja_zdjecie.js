describe('aukcja_zdjecie', () => {
    it('Czy dodano zdjęcie', () => {
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

        const fpath = 'home/images/phot1.png'
        cy.get(input[type="file"]).attachFile(fpath)
        cy.get("Dodaj zdjecie").click()
        cy.get('uploades-files').contains('phot1.png')
        
        cy.contains('Dodaj')
            .click()

        cy.url()
            .should('include', '/newAuction')
    })
})