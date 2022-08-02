describe('Go to the home page', () => {
  beforeEach(() => {

    cy.visit('localhost:3000/')
  })

  it("Clicks on a product", () => {

    cy.get(".products article:first").click()




  });


});