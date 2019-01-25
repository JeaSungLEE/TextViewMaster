# TextViewMaster
[![Version](https://img.shields.io/cocoapods/v/TextViewMaster.svg?style=flat)](http://cocoapods.org/pods/TextViewMaster)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/jeasungLEE/TextViewMaster/blob/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/TextViewMaster.svg?style=flat)](http://cocoapods.org/pods/TextViewMaster)
[![Swift 4.2](https://img.shields.io/badge/Swift-4.2-orange.svg?style=flat)](https://developer.apple.com/swift/)
## Introduce
<img width="300" alt="image" src="https://github.com/JeaSungLEE/TextViewMaster/blob/master/intro.gif">

Easy custom placeholder and growing textView

You can easily adjust the color, font, and position of the placeholder.
The height of the textview automatically changes every time you increase or decrease the line in the textview.

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
    isAnimate: Bool = true                                          //에니메이션 사용여부
    maxLength: Int = 0                                              //최대 글자수
    minHeight: CGFloat = 0                                          //최소 높이 제한
    maxHeight: CGFloat = 0                                          //최대 높이 제한

    placeHolder: String = ""                                        //플레이스홀더
    placeHolderFont: UIFont = UIFont.systemFont(ofSize: 17)         //플레이스홀더 폰트
    placeHolderColor: UIColor = UIColor(white: 0.8, alpha: 1.0)     //플레이스홀더 컬러
    placeHolderTopPadding: CGFloat = 0                              //플레이스홀더 위 여백
    placeHolderBottomPadding: CGFloat = 0                           //플레이스홀더 아래 여백
    placeHolderRightPadding: CGFloat = 5                            //플레이스홀더 오른쪽 여백
    placeHolderLeftPadding: CGFloat = 5                             //플레이스홀더 왼쪽 여백
```
### Programmatically
```ruby
let textViewMaster = TextViewMaster()
textViewMaster.delegate = self       
inputView.addSubview(textViewMaster)
```

If you have difficulty applying, please refer to the example folder.
        
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
