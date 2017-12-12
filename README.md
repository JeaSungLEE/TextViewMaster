# JSGrowingTextView
커지는 텍스트 뷰
## Requirements
* iOS9.0 or higher version
* Swift4
## Usage
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
1. TextView Set class to "JSGrowingTextView".
2. Set delegate to it's view controller

### Delegate
JSGrowingTextView inherits from UITextViewDelegate.
You can also use UITextViewDelegate by default.
Added or modified functions
```ruby
func growingTextView(growingTextView: JSGrowingTextView, shouldChangeTextInRange range:NSRange, replacementText text:String) -> Bool
func growingTextViewShouldReturn(growingTextView: JSGrowingTextView) 
func growingTextView(growingTextView: JSGrowingTextView, willChangeHeight height:CGFloat)
func growingTextView(growingTextView: JSGrowingTextView, didChangeHeight height:CGFloat)
```

## Author
[jeasungLEE](https://github.com/jeasungLEE)

## License
JSGrowingTextView is available under the MIT license.
