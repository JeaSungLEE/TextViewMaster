# TextViewMaster
[![Version](https://img.shields.io/cocoapods/v/TextViewMaster.svg?style=flat)](http://cocoapods.org/pods/TextViewMaster)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/jeasungLEE/TextViewMaster/blob/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/TextViewMaster.svg?style=flat)](http://cocoapods.org/pods/TextViewMaster)
[![Swift 4.2](https://img.shields.io/badge/Swift-4.2-orange.svg?style=flat)](https://developer.apple.com/swift/)
## Introduce
<img width="300" alt="image" src="https://github.com/JeaSungLEE/TextViewMaster/blob/master/intro.gif">

Easy custom placeholder and growing textView

## Requirements
* iOS9.0 or higher version
* Swift4.2


## Installation
### Cocoapods

TextViewMaster is available through [CocoaPods](http://cocoapods.org).

```ruby
pod 'TextViewMaster'
```

## Usage

```ruby
import TextViewMaster
```
### Customization
```ruby
growingTextView.isAnimate = true                                               //에니메이션 사용여부
growingTextView.maxLength = 200                                                //최대 글자수
growingTextView.maxHeight = 500                                                //최대 높이 제한
growingTextView.placeHolder = "메세지를 입력해주세요."                               //플레이스홀더
growingTextView.placeHolderColor = UIColor(white: 0.8, alpha: 1.0)             //플레이스홀더 색상
```
### Programmatically
```ruby
let growingTextView = JSGrowingTextView()
growingTextView.delegate = self
view.addSubview(inputView)
```

Reference example project
        
### Storyboard
1. TextView Set class to "TextViewMaster".
2. Set delegate to it's view controller

### Delegate
TextViewMaster inherits from UITextViewDelegate.
You can also use UITextViewDelegate by default.
Added or modified functions
```ruby
func growingTextView(growingTextView: TextViewMaster, shouldChangeTextInRange range:NSRange, replacementText text:String) -> Bool
func growingTextViewShouldReturn(growingTextView: TextViewMaster) 
func growingTextView(growingTextView: TextViewMaster, willChangeHeight height:CGFloat)
func growingTextView(growingTextView: TextViewMaster, didChangeHeight height:CGFloat)
```

## Author
[jeasungLEE](https://github.com/jeasungLEE)

## License
TextViewMaster is available under the MIT license.
