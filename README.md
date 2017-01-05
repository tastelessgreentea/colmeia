# Colmeia - Challenge
Challenge app for the Colmeia's interview process.

### Quickstart
1. Clone the repo;
1. Install all dependecies: `pod install`;
1. Use `colmeia.xcworkspace` when working on the project. You can do it quickly through the terminal by running: `open colmeia.xcworkspace`.

### Xcode
The current Xcode version being used in this project is 8.2 (8C38).

### Dependencies
This project uses Cocoapods as its dependency manager.
The current version being used is 1.1.1. For more info use this [link](https://cocoapods.org/)
If there are any issues related to the version, use this [thread](http://stackoverflow.com/questions/20487849/downgrading-or-installing-older-version-of-cocoapods), which discusses some ways to deal with it.

### Code Style & Conventions
For style and convetions the tool being used is Swiftlint, the version currently being used is `0.10.0` which can be found in this [link](https://github.com/realm/SwiftLint/releases/tag/0.10.0).

### Tech Stack
* RXSwift as the reactive programming library;
* RXCocoa to enhance the UIKit components so that it is easier to work in a declarative form instead of the default imperative way full of delegates;
* Snapkit, which is a DSL for autolayouting programatically.

### Environments
There is a concept of environments thought Xcode Schemas. The setup was based on the following [guide](http://www.blackdogfoundry.com/blog/migrating-ios-app-through-multiple-environments/).

Currently there are three environments: DEV (environment_DEV.plist), QA (environment_QA.plist) and PROD (environment_PROD.plist).

The idea is that each environment_XXX.plist holds information suchs as Service Keys/Infos such as (Parse, Anaylitics, Crashlogs, etc) and Base URL for backend communitication setup should be per environment.

This will make Continuous Integration based on environments easier.

As a quick benefit, this approach also avoids the bad practice of leaving comments through out the code that configures the app to behave in a specific environment. For instance, pointing to the staging or to the production server.

To select a specific environment just select the proper schema in the top left corner of Xcode.





