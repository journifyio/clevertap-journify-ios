
# CleverTap iOS Journify SDK
[![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-Compatible-F05138.svg)](https://swift.org/package-manager/)


CleverTap integration for Journify-ios.


## Installation

Clevertap-Journify-ios is available through SPM

### Swift Package Manager (SPM)

To add Clevertap-Journify-ios via Swift Package Mangaer:

#### Xcode
![Xcode Add SPM Package](https://user-images.githubusercontent.com/917994/119199146-69765200-ba3f-11eb-9173-93cfb5f3cabd.png)

<img width="1093" alt="Screenshot 2023-02-09 at 5 14 10 PM" src="https://user-images.githubusercontent.com/8136464/217872243-9bc4a114-1807-46c4-9d7b-acbc9d7ba686.png">

<img width="1100" alt="Screenshot 2023-02-09 at 5 14 37 PM" src="https://user-images.githubusercontent.com/8136464/217872395-52dfbff2-f71b-4c5b-b0d2-e880de581ad3.png">

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

