# Meergo Swift SDK (🚧 work in progress)

---

## 🚨 Important note. 🚧 Please note that this SDK is still under development, has not been released, and is therefore not yet usable. Therefore, the commands and documentation provided here may not work or may be changed without notice. Stay tuned for updates. 👀

---

The Meergo Swift SDK lets you send customer event data from your Apple applications (iOS, macOS, tvOS, watchOS, visionOS) to your specified destinations.

## SDK setup requirements

- Set up a Meergo account.
- Set up an Apple source in the dashboard.
- Copy the write key and the endpoint.

## Installation

To integrate the Swift SDK inside your application, add the package dependency to your Xcode project or `Package.swift`. Make sure to replace `<latest_version>` with the latest version of the SDK.

In your `Package.swift`, add the following dependency:

```swift
dependencies: [
    .package(url: "https://github.com/meergo/analytics-swift", from: "<latest_version>")
]
```

Then add `Meergo` as a dependency of your target:

```swift
.target(
    name: "YourApp",
    dependencies: [
        .product(name: "Meergo", package: "analytics-swift")
    ]
)
```

Or, in Xcode, go to **File → Add Package Dependencies...** and enter the repository URL.

## Using the SDK

```swift
import Meergo

let configuration = Configuration(writeKey: "YOUR_WRITE_KEY")
    .endpoint("YOUR_ENDPOINT")
    .setTrackedApplicationLifecycleEvents(.all)
    .flushAt(3)
    .flushInterval(10)
    // ...other config options

let analytics = Analytics(configuration: configuration)

analytics.track(name: "Workout completed", properties: [
    "workout_type": "Cardio",
    "duration_minutes": 45,
    "calories_burned": 380,
    "device": "Smartwatch"
])
```

## Sending events

Refer to the Meergo events documentation for more information on the supported event types.

## Compatibility

* The SDK requires **Swift 5.9** or higher.
* Supported platforms: **iOS 13.0+**, **macOS 10.15+**, **tvOS 13.0+**, **watchOS 7.1+**, **visionOS 1.0+**.

## License
```
MIT License

Copyright (c) 2026 Open2b
Copyright (c) 2021 Segment

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
