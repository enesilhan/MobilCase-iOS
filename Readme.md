# MobilCase-iOS

MobilCase is an iOS case study project developed for Akakçe. The application is built using UIKit and DiffableDataSource while following the MVVM architecture.

## Features

- **Product Listing Screen:**
  - Products are displayed in both horizontal and vertical lists.
  - The horizontal list contains a maximum of 5 products.
  - Efficient list management is achieved using DiffableDataSource.

- **Product Detail Screen:**
  - Displays selected product details such as image, price, and rating.
  - Content is dynamically loaded based on REST API responses.

## Architecture

- **MVVM (Model-View-ViewModel)** is implemented for better separation of concerns.
- **SOLID principles** are followed.
- **UIKit + DiffableDataSource** ensures an efficient listing experience.
- **Unit tests** have been added for ListingViewModel, covering product fetching logic.

## Minimum Deployment Target

- The project supports **iOS 16.0** and above.

## Libraries Used

| Library           | Description |
|------------------|-------------|
| Kingfisher      | Used for asynchronous image loading and caching. |


## Installation

1. **Clone the repository:**
   ```sh
   git clone https://github.com/enesilhan/MobilCase-iOS.git
   cd MobilCase-iOS
   ```

## API Usage

- **Product Listing Endpoint:**  
  `GET https://fakestoreapi.com/products`

- **Product Detail Endpoint:**  
  `GET https://fakestoreapi.com/products/{id}`


## Project Structure

```
MobilCase-iOS
├── Models                # Data models (Product, APIResponse, etc.)
├── Scenes                # Screens built with UIKit
├── Networking            # API calls and network management
└── MobilCase.xcodeproj   # Xcode project file
MobilCase-iOSTests        # Contains unit tests for ViewModels
```

## Git Workflow

- **Branching:**
  - `master` (Main branch)
  - `develop` (Development branch)
  - `feature/xxx` (For new features)
  - `bugfix/xxx` (For fixing issues)

- **Commit Messages (Semantic Commits Format):**
  ```sh
  feat(listing): Added product listing with DiffableDataSource
  fix(api): Fixed JSON parsing issue
  chore(dependency): Update dependencies
  docs(readme): Update documentation
  refactor(viewModel): Improved code structure
  ```

---

