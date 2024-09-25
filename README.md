# SWPhotoEditor

## Overview
SWPhotoEditor s a simple photo editor for iOS. SWPhotoEditor allows users to cropping, drawing and typing. 

## Features
- [x] Cropping
- [x] Drawing with colors
- [x] Typing with colors

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```
To integrate SWPhotoEditor, just add to the Podfile of your project:
```ruby
pod 'PhotoEditor', :git => 'https://github.com/Bezlepkin/SWPhotoEditor.git'
```

Then, run the following command:

```bash
$ pod install
```

## Usage

### Photo
The `PhotoEditorViewController`.

```swift
let photoEditor = PhotoEditorViewController()

// PhotoEditorDelegate
photoEditor.photoEditorDelegate = self

// The image to be edited 
photoEditor.image = image

// Present the View Controller
photoEditor.modalPresentationStyle = .fullScreen
self.present(photoEditor, animated: true, completion: nil)
```
The `PhotoEditorDelegate` methods.

```swift
func doneEditing(image: UIImage) {
    // the edited image
}

func canceledEditing() {
    print("Canceled")
}
```

## Credits
Written by [Igor Bezlepkin](https://github.com/Bezlepkin), inspired by [Mohamed Hamed](https://github.com/M-Hamed).

## License
Released under the [MIT License](http://www.opensource.org/licenses/MIT).
