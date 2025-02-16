# Weather
The weather iOS app provides free access to weather and geo data. This is a sample project used to apply best practices and keep up to date with modern programming languages.
## Compatibility
![](https://img.shields.io/badge/iOS-iOS_17+-informational?style=flat&logo=iOS&logoColor=white&color=2bbc8a)
![](https://img.shields.io/badge/Swift-4-informational?style=flat&logo=Swift&logoColor=white&color=2bbc8a)
![](https://img.shields.io/badge/Swift-5-informational?style=flat&logo=Swift&logoColor=white&color=2bbc8a)
![](https://img.shields.io/badge/Swift-6-informational?style=flat&logo=Swift&logoColor=white&color=2bbc8a)

## Frameworks
![Frameworks](https://img.shields.io/badge/API-SwiftUI-informational?style=flat&logo=Framework&logoColor=white&color=2bbc8a)
![Frameworks](https://img.shields.io/badge/API-Testing-informational?style=flat&logo=Framework&logoColor=white&color=2bbc8a)
![Frameworks](https://img.shields.io/badge/API-Concurrency-informational?style=flat&logo=Framework&logoColor=white&color=2bbc8a)
![Frameworks](https://img.shields.io/badge/API-OSLog-informational?style=flat&logo=Framework&logoColor=white&color=2bbc8a)
![Frameworks](https://img.shields.io/badge/Framework-SwiftPM-informational?style=flat&logo=Framework&logoColor=white&color=2bbc8a)

## App Architecture
The weather-tracking app has a single feature component. `Landing Page` is a self-contained feature component with some module dependencies as shown in the graph below.
```mermaid
graph TD;
    WeatherApp-->LandingPage;
    LandingPage-->RestAPI;
    RestAPI-->EndpointManager;
    RestAPI-->WTLogging;
    EndpointManager-->WTLogging;
    RestAPI-->Networking;
    Networking-->WTLogging;
    LandingPage-->DecoratorUI;
```

## Weather app images
| No location selected | Searching loading | Location details | Error handler
| ---- | ---- | ---- | ---- |
| <img src="https://github.com/user-attachments/assets/99563261-6435-4550-8054-68d6ea7c6792" alt="No city selected" width="200"> | <img src="https://github.com/user-attachments/assets/2bbd802d-576e-4c8c-b154-0c0eb443ffbf" alt="Search loading" width="200"> | <img src="https://github.com/user-attachments/assets/14c83383-b927-49a0-b985-ac94d0411175" alt="Location details" width="200"> | <img src="https://github.com/user-attachments/assets/fdf4cc61-d0d8-4be5-bacd-d780d2daf7a0" alt="Error handler" width="200"> |

| Searching result | Details |
| ---- | ---- |
| <img src="https://github.com/user-attachments/assets/00539ad5-72c0-4c66-ba94-926681db604f" alt="Searching result" width="200"> | <img src="https://github.com/user-attachments/assets/125e86ad-5a79-4e09-a6e1-09fb0018c9c5" alt="Location details" width="200"> |



### Steps to Run the App


1. Clone the Repository
    - Run the following command in your terminal:
    ```
    git clone git@github.com:mrugama/Weather.git
    ```
2. Open the Project
    - Open the project in Xcode by double-clicking on Weather.xcodeproj.
3. Update Key API
    - Go to the file [EndpointManager](https://github.com/mrugama/Weather/blob/f79f74f70b42f9f3eae7eed950832a32c1bedf3c/WeatherCore/Sources/Foundation/EndpointManager/Implementation/EndpointManager%2BImplementation.swift#L16) and paste your own API key. Please go to [The Weather API documentation](https://www.weatherapi.com/docs/) to get your API Key
4. Run the App
    - Select the desired simulator or device in Xcode.
    - Press the Run button (▶️) or use the shortcut Cmd + R to build and launch the app.

## Test Coverage
