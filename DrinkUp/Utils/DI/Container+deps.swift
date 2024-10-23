import Factory

extension Container {

    var cocktailsService: Factory<CocktailsService> {
        Factory(self) { CocktailsAPI() }
    }
    
    var cocktailDetailsService: Factory<CocktailDetailsService> {
        Factory(self) { CocktailDetailsAPI() }
    }
}
