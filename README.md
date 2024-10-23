
# An iOS app recruitment task

- [Task requirements](#task-requirements)
- [Additional app features](#additional-app-features)
- [Installation](#installation)
- [Technical details](#technical-details)
- [Used libraries](#used-libraries)
- [Additional info](#additional-info)

## Task requirements

- iOS app, presenting data from [TheCocktailDB](https://www.thecocktaildb.com)
- a search screen, allowing searching the DB by ingredient name and displaying search results list (name and thumbnail),
- a details screen, presenting extended data about a cocktail selected from the list (at minimum - name and thumbnail).

## Additional app features

- searching by either cocktail name or ingredient name
- non-alcoholic drinks filtering
- cocktail ingredients listed on the details screen

## Installation

Xcode 16 with at least iOS 17 SDK installed is required. The app downloads its dependencies via SPM, no prerequisites needed. Automatic code signing is enabled for the project.

## Technical details

- full SwiftUI app in MVVM
- Dependecies via SPM
- SwiftUI previews
- Some Combine for handling user input
- Unit tests for view models (no 100% coverage, just smoke test cases, parallel running disabled due to low count of the test cases)
- Light and Dark Mode support
- Localization in en and pl languages

## Used libraries

- [Alamofire](https://github.com/Alamofire/Alamofire) for networking
- [Kingfisher](https://github.com/onevcat/Kingfisher) for web image caching
- [Factory](https://github.com/hmlongco/Factory) for dependency injection
- [SwiftLint](https://github.com/realm/SwiftLint) for build-time linting

## Additional info

Xcode shows a warning about SwiftLint's `opening_brace` rule when building. This is a SwiftLint error, it has been reported and resolved in [#5791](https://github.com/realm/SwiftLint/issues/5791), but hasn't been released yet.