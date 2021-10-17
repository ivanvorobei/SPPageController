# SPPageController

<a href="https://opensource.ivanvorobei.by/sppagecontroller/preview">
    <img align="left" src="https://cdn.ivanvorobei.by/github/sppagecontroller/example-app-preview-1.0.1.png" width="240"/>
</a>

### About

Mimicrate to native `UIPageViewController`. Each page is new controller, it can be even navigation controller.
 Support parent layout margins, paging and scroll by index. 
 
 <p float="left">
    <a href="https://opensource.ivanvorobei.by/sppagecontroller/preview">
        <img src="https://github.com/ivanvorobei/Readme/blob/main/Buttons/video-preview.svg">
    </a>
</p>

Don't have bug with tranlation when rotate like apple's `UIPageViewController`. Also you can scroll to any page programatically. If you need pages for inboarding, you can disable scroll by gester.

If you like the project, don't forget to `put star ★`<br>Check out my other libraries:

<p float="left">
    <a href="https://opensource.ivanvorobei.by">
        <img src="https://github.com/ivanvorobei/Readme/blob/main/Buttons/more-libraries.svg">
    </a>
</p>

## Navigate

- [Installation](#installation)
    - [Swift Package Manager](#swift-package-manager)
    - [CocoaPods](#cocoapods)
    - [Manually](#manually)
- [Usage](#usage)
    - [Present](#usage)
    - [Scroll](#scroll)
    - [Dismiss](#dismiss)
- [Сontribution](#сontribution)
- [Other Projects](#other-projects)
- [Russian Community](#russian-community)

## Installation

Ready for use on iOS 12+. Works with Swift 5+. Required Xcode 12.0 and higher.

<img align="right" src="https://cdn.ivanvorobei.by/github/sppagecontroller/spm-install-preview.png" width="550"/>

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

Once you have your Swift package set up, adding as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/ivanvorobei/SPPageController.git", .upToNextMajor(from: "1.0.0"))
]
```

### CocoaPods:

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'SPPageController'
```

### Manually

If you prefer not to use any of dependency managers, you can integrate manually. Put `Sources/SPPageController` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.

## Usage

`SPPageController` is simple container controller. You can create, pass child controllers which using like pages and simple present page controller as you need:

```swift
let controllers: [UIViewController] = []
let pageController = SPPageController(viewControllers: controllers)
present(pageController, animated: true, completion: nil)
```

You can manage layout margins of container. Apple still has bug with it, but my way support it correctly:

```swift
pageController.view.layoutMargins = .init(horizontal: 50, vertical: 0)

// Don't forget enable preserve layout margins for childs:
// childController.view.preservesSuperviewLayoutMargins = true
```

Now for all childs left and right margins will be +50pt.

### Scroll

If you want scroll only programatically, disable scroll between pages by gester:

```swift
pageController.allowScroll = false
```

### Dismiss

If need disable dismiss by gester (related for modal controllers), set flag to `false`:

```swift
pageController.allowDismissWithGester = false
```

## Сontribution

My English is very bad. You can see this once you read the documentation. I would really like to have clean and nice documentation. If you see gramatical errors and can help fix the Readme, please contact me hello@ivanvorobei.by or make a Pull Request. Thank you in advance!

## Other Projects

I love being helpful. Here I have provided a list of libraries that I keep up to date. For see `video previews` of libraries without install open [opensource.ivanvorobei.by](https://opensource.ivanvorobei.by) website.<br>
I have libraries with native interface and managing permissions. Also available pack of useful extensions for boost your development process.

<p float="left">
    <a href="https://opensource.ivanvorobei.by">
        <img src="https://github.com/ivanvorobei/Readme/blob/main/Buttons/more-libraries.svg">
    </a>
        <a href="https://xcodeshop.ivanvorobei.by">
        <img src="https://github.com/ivanvorobei/Readme/blob/main/Buttons/xcode-shop.svg">
    </a>
</p>

## Russian Community

Подписывайся в телеграмм-канал, если хочешь получать уведомления о новых туториалах.<br>
Со сложными и непонятными задачами помогут в чате.

<p float="left">
    <a href="https://tutorials.ivanvorobei.by/telegram/channel">
        <img src="https://github.com/ivanvorobei/Readme/blob/main/Buttons/open-telegram-channel.svg">
    </a>
    <a href="https://tutorials.ivanvorobei.by/telegram/chat">
        <img src="https://github.com/ivanvorobei/Readme/blob/main/Buttons/russian-community-chat.svg">
    </a>
</p>

Видео-туториалы выклыдываю на [YouTube](https://tutorials.ivanvorobei.by/youtube):

[![Tutorials on YouTube](https://cdn.ivanvorobei.by/github/readme/youtube-preview.jpg)](https://tutorials.ivanvorobei.by/youtube)
