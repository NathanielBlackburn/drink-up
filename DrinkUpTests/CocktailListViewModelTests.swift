import XCTest
import Factory
import Combine
@testable import DrinkUp

@MainActor
final class CocktailListViewModelTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        Container.shared.cocktailsService.register { MockCocktailsAPI() }
    }
    
    func testListEmptyOnStart() {
        let vm = CocktailListViewModel()

        XCTAssertEqual(vm.cocktails.count, 0)
    }
    
    func testLoadingList() async {
        var isLoadingStates = [Bool]()
        let vm = CocktailListViewModel()
        let expectation = XCTestExpectation(description: "Toggles the isLoading flag two times")

        vm.$isLoading
            .dropFirst()
            .sink {
                isLoadingStates.append($0)
                if isLoadingStates.count == 2 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        vm.searchText = "rum"
        
        await fulfillment(of: [expectation], timeout: 1)

        XCTAssertEqual(isLoadingStates, [true, false])
    }

    func testSearchByIngredient() async {
        let vm = CocktailListViewModel()
        let expectation = XCTestExpectation(description: "Finished loading")

        vm.$isLoading
            .dropFirst()
            .sink { isLoading in
                if !isLoading {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        vm.searchText = "vodka"

        await fulfillment(of: [expectation], timeout: 1)

        XCTAssertEqual(vm.cocktails.count, 2)
        XCTAssertEqual(vm.cocktails[0].name, "Vodka Martini")
        XCTAssertEqual(vm.cocktails[1].name, "Bloody Mary")
    }

    func testSearchByName() async {
        let vm = CocktailListViewModel()
        let expectation = XCTestExpectation(description: "Finished loading")

        vm.$isLoading
            .dropFirst()
            .sink { isLoading in
                if !isLoading {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        vm.searchByName.toggle()
        vm.searchText = "CuBa"

        await fulfillment(of: [expectation], timeout: 1)

        XCTAssertEqual(vm.cocktails.count, 1)
        XCTAssertEqual(vm.cocktails.first?.name, "Cuba Libre")
    }
    
    func testSearchResultsEmpty() async {
        let vm = CocktailListViewModel()
        let expectation = XCTestExpectation(description: "Finished loading")
        
        vm.$isLoading
            .dropFirst()
            .sink { isLoading in
                if !isLoading {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        vm.searchText = "kahlua"
        
        await fulfillment(of: [expectation], timeout: 1)
        
        XCTAssertEqual(vm.cocktails.count, 0)
    }

    func testErrorOnLoadingResults() async {
        Container.shared.cocktailsService.register { MockErrorCocktailsAPI() }

        let vm = CocktailListViewModel()
        let expectation = XCTestExpectation(description: "Finished loading")
        
        vm.$isLoading
            .dropFirst()
            .sink { isLoading in
                if !isLoading {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        vm.searchText = "rum"
        
        await fulfillment(of: [expectation], timeout: 1)
        
        XCTAssertEqual(vm.cocktails.count, 0)
        XCTAssertEqual(vm.error as? APIError, APIError.malformedURL)
    }
}
