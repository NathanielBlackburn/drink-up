import Foundation

// swiftlint:disable force_unwrapping
extension Cocktail {

    static func createMocks() -> [Cocktail] {
        [
            Cocktail(
                id: "10001",
                name: "Margarita",
                thumbnail: URL(string: "https://www.thecocktaildb.com/images/media/drink/tpxurs1454513016.jpg")!,
                isNonAlcoholic: false
            ),
            Cocktail(
                id: "10002",
                name: "Orange Smoothie",
                thumbnail: URL(string: "https://www.thecocktaildb.com/images/media/drink/tpxurs1454513016.jpg")!,
                isNonAlcoholic: true
            ),
            Cocktail(
                id: "10003",
                name: "Vodka Martini",
                thumbnail: URL(string: "https://www.thecocktaildb.com/images/media/drink/tpxurs1454513016.jpg")!,
                isNonAlcoholic: false
            ),
            Cocktail(
                id: "10004",
                name: "Cuba Libre",
                thumbnail: URL(string: "https://www.thecocktaildb.com/images/media/drink/tpxurs1454513016.jpg")!,
                isNonAlcoholic: false
            ),
            Cocktail(
                id: "10005",
                name: "Bloody Mary",
                thumbnail: URL(string: "https://www.thecocktaildb.com/images/media/drink/tpxurs1454513016.jpg")!,
                isNonAlcoholic: false
            ),
        ]
    }
}
// swiftlint:enable force_unwrapping
