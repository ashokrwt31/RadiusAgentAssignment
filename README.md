# RadiusAgentAssignment - Solution

## Functionality Overview

The RadiusAgentAssignment solution involves creating a user interface (UI) to display a list of facilities and their options. Users can select one option from each facility. The UI also implements exclusion conditions, where certain combinations of options are not allowed to be selected together. The solution addresses this by disabling incompatible options based on the user's selections.

## Design Pattern/Architecture

The assignment solution has been implemented using the Model-View-ViewModel (MVVM) design pattern. MVVM separates the application into three main components:

- `Model`: Represents the data and business logic of the application.
- `View`: Handles the presentation and user interface components.
- `ViewModel`: Acts as a bridge between the Model and View, providing data and commands for the View to display and interact with.

The MVVM design pattern was chosen for its benefits in terms of separation of concerns, testability, and maintainability. It allows for better code organization and facilitates unit testing of individual components.

## Third-Party Library

No third-party libraries or frameworks are used in this solution. The functionality is implemented using native iOS development tools and components.

## Usages

To use this app, open project in Xcode, build it, and run it on a simulator or physical device. The app fetches data from the API and displays a list of properties with selectable options. Users can select options from each set, and the app applies exclusion criteria to prevent invalid selections.  
