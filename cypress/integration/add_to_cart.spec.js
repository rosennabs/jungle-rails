describe("Jungle app", () => {
  beforeEach(() => {
    // Cypress starts out with a blank slate for each test
    // so we must tell it to visit our website with the `cy.visit()` command.
    // Since we want to visit the same URL at the start of all our tests,
    // we include it in our beforeEach function so that it runs before each test
    cy.visit("http://localhost:3000");
  });

  it("should display the homepage title", () => {
    // Use Cypress commands to interact with the page and make assertions
    cy.get("h1").should("contain", "The Jungle");
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 12 products on the page", () => {
    cy.get(".products article").should("have.length", 12);
  });

   it("should add a product to the cart", () => {
     // Find the first "Add to Cart" button on the page and click it
     cy.get(".btn").first().click({ force: true });

     // Assert that the cart count has increased by one
     cy.get("li.nav-item.end-0").should("contain", "1");
   });
});
