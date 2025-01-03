
# ⚡️ Harry Potter App

A beautifully designed Harry Potter app built using __Swift and UIKit__, featuring all your favorite characters from the wizarding world. This project showcases modern iOS development practices, including __Combine, MVVM architecture, and Diffable Data Sources__ for smooth and efficient UI updates. The entire app UI is built __programmatically__, ensuring a highly customizable and flexible design.
## 🧙‍♂️ Features

- Display Houses and Books
- Character List: Browse a complete list of Harry Potter characters with detailed profiles.
- Search Functionality: Quickly find your favorite characters using the built-in search bar
- Favorites: Save your favorite characters to a separate list for easy access.
- Dark mode support
## 🛠️ Architecture & Design Patterns
### MVVM (Model-View-ViewModel)
- CharacterModel: Data model for character information
- CharactersView: UI layer
- CharactersViewModel: Business logic and data management
- CharactersViewModelProtocol: Protocol for dependency injection

### Protocols & Delegates
- CharacterCellDelegate: Handles favorite button actions
- CharactersViewModelProtocol: Defines ViewModel interface

### Singleton
- UserDefaultsManager: Manages local storage operations

## Data Source Patterns
- UICollectionViewDiffableDataSource: Modern data source implementation
- NSDiffableDataSourceSnapshot: Handles collection view updates
  
# 📸 Screenshots
<img width=200 src= "https://github.com/user-attachments/assets/c088ec73-cc51-402e-8d9f-a230dd5a6ebb" >
<img width=200 src= "https://github.com/user-attachments/assets/30ad6102-451e-4526-8f82-51c92b1f07a8" >
<img width=200 src= "https://github.com/user-attachments/assets/033310e2-72db-4498-baad-084aa9e0d273" >

