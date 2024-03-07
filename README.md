# ⚙️ Swift Trade

**Swift Trade** is a Watcher wallet.
Our application will retrieve this information using the API: https://api.ethplorer.io/ specifying the address as input:
- Wallet address
- Wallet balance
- Wallet details
- Wallet NFTs
- NFT details
##
- [Requirements](#requirements)
- [Features](#features)
- [Project Architecture](#project-architecture)
- [Licence](#licence)
##
## Requirements

Swift Trade Application is build using **Swift v5.9.2** 

* Xcode v15.2 
* Swift v5.9.2
* Xcode 15.2 requires a Mac running macOS Sonoma 14.3 or later.
* Simulator or Device with **iOS 17.0** or later

## Features

Swift Trade Application Core is build to the application, plus some variations to its principle logic, such as:

* SwiftUI Form to handle user inputs.
* Combine Form validation.
* SwiftData for data persistence
* Well Documented. 
* UnitTests to core methods.
* Absolutly Zero depending on 3rd party packages.


## Project Architecture
The project respects the **Clean architecture** architecture. 

In the **Presentation** layer I defined:
* Custom UI Components.
* Screens
* ViewModel

In the **Domain** layer I defined:
* Entities
* Repositories
* UseCases

In the **Data** layer I defined:
* Repositories implementation.
* DTO
* Data Sources

## License

Swift Trade is under [GPL](https://github.com/Illumina/licenses/blob/master/gpl-3.0.txt)-licensed v3.0.
