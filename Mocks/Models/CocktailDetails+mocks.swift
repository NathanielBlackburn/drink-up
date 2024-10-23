import Foundation

// swiftlint:disable force_unwrapping
extension CocktailDetails {

    static func createMock(isNonAlcoholic: Bool = false, whiteBackground: Bool = false) -> CocktailDetails {
        CocktailDetails(
            id: "1001",
            name: "Margarita",
            category: "Ordinary Drink",
            isNonAlcoholic: isNonAlcoholic,
            glass: "Cocktail glass",
            thumbnail: URL(
                string: whiteBackground
                    ? "https://www.thecocktaildb.com/images/media/drink/qyyvtu1468878544.jpg"
                    : "https://www.thecocktaildb.com/images/media/drink/tpxurs1454513016.jpg"
            )!,
            ingredients: [
                Ingredient(name: "Tequila", measure: "1 1/2 oz"),
                Ingredient(name: "Triple sec", measure: "1/2 oz"),
                Ingredient(name: "Lime juice", measure: "1 oz"),
                Ingredient(name: "Salt", measure: nil),
            ]
        )
    }
}
// swiftlint:enable force_unwrapping
