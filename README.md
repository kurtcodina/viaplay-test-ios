# Viaplay API – iOS Work Sample

A simple SwiftUI iOS app that uses the array of sections returned by the Viaplay API [Endpoint for iOS devices](https://content.viaplay.com/ios-se), displays all available sections, see each section title and description, and allows users to navigate between them. The app works both **online** and subsequently **offline** by caching the latest successful response.  

This project is designed as a **starting point for a future codebase**: cleanly structured, testable, and easy to extend.

---

## Features
- Fetches and decodes `viaplay:sections` from the Viaplay API.  
- Displays **title** and **description** of each section.  
- Allows navigation into each section using the provided `href`, ignoring the URI templating.  
- **Works offline**: falls back to cached data when no network is available.  
- Marks **cached content** as so the user knows they’re seeing offline data.  
- Includes **unit tests** for decoding models from the API and caching.  
- Includes **UI tests** for navigation and displaying loaders and error messages.  

---

## Architecture
The app is structured with future scalability in mind:

```
/Sources
  /Models          // Codable data structures for API
  /Networking      // APIClient protocol + ViaplayAPIClient implementation
  /Persistence     // File-based cache for offline mode
  /ViewModels      // Observables that drive UI state
  /Views           // SwiftUI UI components
  /Extensions      // Helper functions
/Tests
  /UnitTests       // Model and cache tests
  /UITests         // Basic navigation, loading, and offline state tests
  /TestSupport
    /Mocks         // Mock data and objects for unit and UI tests
```

- **Dependency Injection** is used (APIClient, Cache) → testability + flexibility.  
- **Protocols** define boundaries (`APIClient`).  
- **SwiftUI + MVVM** keeps UI simple and reactive.  

---

## Getting Started

### Prerequisites
- Xcode 15+  
- iOS 17+ (deployment target)  

### Installation
Clone the repository:
```bash
git clone https://github.com/kurtcodina/viaplay-test-ios.git
cd Viaplay-Test
open Viaplay-Test.xcodeproj
```

Run on simulator or device from Xcode.  

---

## Testing

Run all tests:
```bash
⌘U in Xcode
```

Test coverage includes:
- **Model decoding** (handles `title`,`description`, and `viaplay:sections`)  
- **Cache layer** (save, load, invalid data)  
- **UI tests** (navigation between sections, loading, and error messages)  

---

## Offline Behavior

- On successful fetch, the raw JSON response is cached per endpoint in `ApplicationSupport/FileCache/<SHA256(endpoint)>.json`.  
- If the app launches without a network connection, it attempts to load cached data for the requested endpoint.  
- Cached results are marked as **stale** in the UI.  

---

## Future Improvements
This implementation was a quick test. Next steps to make it production-ready:  
- Properly support **URI templating** (instead of stripping).  
- Handle **pagination** and larger datasets.  
- Replace file cache with **Core Data** or SQLite for scalable offline storage.  
- Add **background refresh** to keep offline data up-to-date.  
- Improve error handling and retry logic. 
- Implement **ViaplayPageProtocol** to easily add new page types or link types without breaking existing code.

---

## Tooling
- **Swift 5.9**  
- **SwiftUI** for UI  
- **XCTest** for unit + UI testing

---

## Screenshots
![small1](https://github.com/user-attachments/assets/cdd09218-16c5-41bf-a821-4176229c33aa)
![small2](https://github.com/user-attachments/assets/531ccc13-2146-4833-a007-0c7bc01f4199)
---

## License
MIT License – see [LICENSE](https://mit-license.org/) for details.  
