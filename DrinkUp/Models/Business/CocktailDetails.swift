import Foundation

struct CocktailDetails: Identifiable {
    
    let id: String
    let name: String
    let category: String
    let isNonAlcoholic: Bool
    let glass: String
    let thumbnail: URL
    let ingredients: [Ingredient]
}

extension CocktailDetails: Codable {

    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case category = "strCategory"
        case isNonAlcoholic = "strAlcoholic"
        case glass = "strGlass"
        case thumbnail = "strDrinkThumb"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.category = try container.decode(String.self, forKey: .category)
        let alcoholContent = try container.decode(String.self, forKey: .isNonAlcoholic)
        self.isNonAlcoholic = alcoholContent == "Non alcoholic"
        self.glass = try container.decode(String.self, forKey: .glass)
        self.thumbnail = try container.decode(URL.self, forKey: .thumbnail)
        let ingredientContainer = try decoder.container(keyedBy: DynamicCodingKey.self)
        var ingredients = [Ingredient]()
        for index in 0...16 {
            if let ingredientCodingKey = DynamicCodingKey(stringValue: "strIngredient\(index)"),
               let ingredient = try ingredientContainer.decodeIfPresent(String.self, forKey: ingredientCodingKey),
               let measureCodingKey = DynamicCodingKey(stringValue: "strMeasure\(index)") {
                let measure = try ingredientContainer.decodeIfPresent(String.self, forKey: measureCodingKey)
                ingredients.append(Ingredient(name: ingredient, measure: measure))
            }
        }
        self.ingredients = ingredients
    }
}
