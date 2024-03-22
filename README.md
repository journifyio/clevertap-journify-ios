
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


## License

[MIT](https://choosealicense.com/licenses/mit/)

## Credits

This SDK was based of Segment Swift SDK [https://github.com/segmentio/analytics-swift](https://github.com/segmentio/analytics-swift) (Thanks to the Segment team)

