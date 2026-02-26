
# CleverTap iOS Journify SDK
[![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-Compatible-F05138.svg)](https://swift.org/package-manager/)


CleverTap integration for Journify-ios.


## Installation

Clevertap-Journify-ios is available through SPM

### Swift Package Manager (SPM)

To add Clevertap-Journify-ios via Swift Package Mangaer:

#### Xcode
![Xcode Add SPM Package](https://user-images.githubusercontent.com/917994/119199146-69765200-ba3f-11eb-9173-93cfb5f3cabd.png)

<img width="1035" alt="Screenshot 2024-03-22 at 1 59 56 PM" src="https://github.com/journifyio/clevertap-journify-ios/assets/8136464/d33a5372-6d36-407d-9926-4df32481fe29">

<img width="1032" alt="Screenshot 2024-03-22 at 2 00 16 PM" src="https://github.com/journifyio/clevertap-journify-ios/assets/8136464/a5ca3877-3ecb-4a6f-82b5-e592ac430473">


Note: Clevertap-Journify-ios recommends that you use Xcode to add your package.

## Usage/Examples

```Swift
//Enable debug mode
CleverTap.setDebugLevel(CleverTapLogLevel.debug.rawValue)
Journify.debugLogsEnabled = true
        
//Setup Journify
let configuration = Configuration(writeKey: "Your_Key")
    .trackApplicationLifecycleEvents(true)
    .flushInterval(10)
Journify.setup(with: configuration)
        
//Setup & Add cleverTapDestination
let cleverTapDestination = CleverTapDestination(accountID: "Your_Account_ID", token: "Your_Account_Token", region: "Your_Region")
Journify.shared().add(plugin: cleverTapDestination)

```


## Development

### Requirements

- Xcode 14+
- Swift 5.3+
- iOS 13.0+

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/journifyio/clevertap-journify-ios.git
   cd clevertap-journify-ios
   ```

2. Resolve dependencies:
   ```bash
   swift package resolve
   ```

3. Open the example app:
   ```bash
   open Example/SwiftExample/SwiftExample.xcodeproj
   ```

4. In Xcode, go to **File > Packages > Resolve Package Versions** to sync the workspace dependencies.

### Running the Example App

The example app (`Example/SwiftExample`) lets you test the integration end-to-end. On launch it prompts for:

- **Journify Write Key** — your Journify source write key
- **CleverTap Account ID** — from the CleverTap dashboard
- **CleverTap Token** — from the CleverTap dashboard
- **CleverTap Region** - from the CleverTap dashboard

### Project Structure

```
.
├── Sources/CleverTapDestination/   # SDK source
├── Example/SwiftExample/           # Example Xcode project
├── Package.swift                   # SPM manifest
└── Package.resolved                # Pinned dependency versions
```

## License

[MIT](https://choosealicense.com/licenses/mit/)

## Credits

This SDK was based of Segment Swift SDK [https://github.com/segmentio/analytics-swift](https://github.com/segmentio/analytics-swift) (Thanks to the Segment team)

