import XCTest
import Factory
import Combine
@testable import DrinkUp

final class CocktailDetailsViewModelTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()

    func testDetailsEmptyOnStart() {
        let vm = CocktailDetailsViewModel()

        XCTAssertNil(vm.details)
    }
    
    func testLoadingDetails() async {
        Container.shared.cocktailDetailsService.register { MockCocktailDetailsAPI() }
        let vm = CocktailDetailsViewModel()
        vm.id = "1001"
        await vm.fetch()

        XCTAssertNotNil(vm.details)
        XCTAssertEqual(vm.details?.id, "1001")
        XCTAssertEqual(vm.details?.name, "Margarita")
    }

    func testErrorOnLoadingDetails() async {
        Container.shared.cocktailDetailsService.register { MockErrorCocktailDetailsAPI() }

        let vm = CocktailDetailsViewModel()
        vm.id = "1001"
        await vm.fetch()
        
        XCTAssertNil(vm.details)
        XCTAssertEqual(vm.error as? APIError, APIError.malformedURL)
    }
}
