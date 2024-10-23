import Foundation

struct Cocktail: Identifiable {

    let id: String
    let name: String
    let thumbnail: URL
    let isNonAlcoholic: Bool
}

extension Cocktail: Codable {

    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case thumbnail = "strDrinkThumb"
        case isNonAlcoholic = "strAlcoholic"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.thumbnail = try container.decode(URL.self, forKey: .thumbnail)
        let alcoholContent = try container.decodeIfPresent(String.self, forKey: .isNonAlcoholic)
        self.isNonAlcoholic = alcoholContent == "Non alcoholic"
    }
}
