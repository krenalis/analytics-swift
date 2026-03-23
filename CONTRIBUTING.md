# Contributing

This document provides information useful for contributing to the Krenalis Swift SDK.

## Prerequisites

Before you begin, make sure you have [Xcode 26](https://developer.apple.com/xcode/) or later installed.

To verify your Xcode version:

```bash
xcodebuild -version
```

## Testing the SDK

Tests can be run locally on macOS:

**macOS (Swift Package Manager):**

```bash
swift test
```

**iOS:**

```bash
xcodebuild -scheme Krenalis test -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 17'
```

**tvOS:**

```bash
xcodebuild -scheme Krenalis test -sdk appletvsimulator -destination 'platform=tvOS Simulator,name=Apple TV'
```

**watchOS:**

```bash
xcodebuild -scheme Krenalis test -sdk watchsimulator -destination 'platform=watchOS Simulator,name=Apple Watch Ultra 3 (49mm)'
```

**visionOS:**

```bash
xcodebuild -scheme Krenalis test -destination 'platform=visionOS Simulator,OS=26.0,name=Apple Vision Pro'
```

## Running the sample application

To run the sample application locally:

1. Open `Examples/apps/BasicExample` in Xcode.

2. Open `AppDelegate.swift` and replace `WRITE_KEY` and `ENDPOINT` with the values from your Krenalis Apple source.

3. Build and run the application from Xcode on an iOS Simulator.

4. Interact with the buttons inside the application running in the simulator. You should see new logged events in the event debugger of the Krenalis Apple source.
