# Slib

uses TVmaze API ([ref](https://www.tvmaze.com/api)) to build an application that:
- shows tv shows, with pagination
- allows user to search from api
- shows tv show details, seasons and episodes once selected

### dependencies

- Kingfisher - to facilitate handling with remote images
- SnapKit - used for setting constraints in a more elegant way

the dependency manager is being done with Swift Package Manager


### network layer

no frameworks were used. a custom network layer based on Alamofire's Router strategy was built to attend the project needs. didn't want to import a giant library for only doing some get requests

### ui components

ui components are being kept padronized via a ViewStyle structure created for the project also

### next steps

- unit testing
- ui testing
- localizable strings
- some layout enhancements
- viewForHeaderInSection for sections in SeriesDetail
