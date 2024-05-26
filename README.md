<p align="center">
   <img width="200" src="https://raw.githubusercontent.com/SvenTiigi/SwiftKit/gh-pages/readMeAssets/SwiftKitLogo.png" alt="AlertMaster Logo">
</p>

<p align="center">
   <a href="https://developer.apple.com/swift/">
      <img src="https://img.shields.io/badge/Swift-5.2-orange.svg?style=flat" alt="Swift 5.2">
   </a>
   <a href="https://github.com/apple/swift-package-manager">
      <img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" alt="SPM">
   </a>
</p>

# AlertMaster

<p align="center">
UIKit library for creating fully configurable alert screens
</p>

<p align="center">
   <img src="https://i.imgur.com/kGPuzOv.png" alt="Screenshot">
</p>

## Example

The example application is the best way to see `AlertMaster` in action. Simply open the `AlertMasterExample.xcodeproj` and run the `AlertMasterExample` scheme.

## Installation
The library requires a dependency [AppViewUtilits](https://github.com/moslienko/AppViewUtilits/).

### Swift Package Manager

To integrate using Apple's [Swift Package Manager](https://swift.org/package-manager/), add the following as a dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/moslienko/AlertMaster.git", from: "1.0.0")
]
```

Alternatively navigate to your Xcode project, select `Swift Packages` and click the `+` icon to search for `AlertMaster`.

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can integrate AlertMaster into your project manually. Simply drag the `Sources` Folder into your Xcode project.

## Usage

### Components


### Config
All detailed customization of alert properties is done using the class `AlertConfig`.

### Animation of screen appearance and closing

To create your own implementation of the alert screen appearance and closing animation, you need to create a class following the `AlertScreenPresentable` protocol. 

 ```swift
class RotatePresentable: AlertScreenPresentable {
  func showView(backgroundView: UIView, alertView: UIView) {
    UIView.animate(withDuration: 0.35) {}
  }

  func hideView(backgroundView: UIView, alertView: UIView, finished: (() -> Void)?) {
    UIView.animate(withDuration: 0.35, animations: {}) { _ in
      finished?()
    }
  }
}
```

Then set it in the config:

 ```swift
var alertConfig = AlertConfig()
alertConfig.presentableService = RotatePresentable()
```


## License

```
AlertMaster
Copyright (c) 2024 Pavel Moslienko 8676976+moslienko@users.noreply.github.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
