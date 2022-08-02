describe('Go to the home page', () => {
  beforeEach(() => {
    cy.visit('localhost:3000/')
  })

  it("Add a product to the cart", () => {
    cy
      .get(".products article").first()
      .get(".btn").first()
      .click()
      .get(".navbar-nav:last").should("include.text", "My Cart (1)")
  });
});