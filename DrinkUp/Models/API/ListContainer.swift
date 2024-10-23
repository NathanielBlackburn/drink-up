struct ListContainer<Model: Codable> {

    let drinks: [Model]
}

extension ListContainer: Codable {

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.drinks = try container.decode([Model].self, forKey: .drinks)
    }
}
