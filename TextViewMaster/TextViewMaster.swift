//
//  JSGrowingTextView.swift
//  JSGrowingTextView
//
//  Created by jeasung.lee on 2017. 12. 12..
//  Copyright © 2017년 jeasungLEE. All rights reserved.
//

import UIKit

@objc public protocol TextViewMasterDelegate: UITextViewDelegate {
    @objc optional func growingTextView(growingTextView: TextViewMaster, shouldChangeTextInRange range:NSRange, replacementText text:String) -> Bool
    @objc optional func growingTextViewShouldReturn(growingTextView: TextViewMaster)
    
    @objc optional func growingTextView(growingTextView: TextViewMaster, willChangeHeight height:CGFloat)
    @objc optional func growingTextView(growingTextView: TextViewMaster, didChangeHeight height:CGFloat)
}

//MARK: -
public class TextViewMaster: UITextView {
    public var isAnimate: Bool = true                                          //에니메이션 사용여부
    public var maxLength: Int = 0                                              //최대 글자수
    public var minHeight: CGFloat = 0                                          //최소 높이 제한
    public var maxHeight: CGFloat = 0                                          //최대 높이 제한

    public var placeHolder: String = ""                                        //플레이스홀더
    public var placeHolderFont: UIFont = UIFont.systemFont(ofSize: 17)         //플레이스홀더 폰트
    public var placeHolderColor: UIColor = UIColor(white: 0.8, alpha: 1.0)     //플레이스홀더 컬러
    public var placeHolderTopPadding: CGFloat = 0                              //플레이스홀더 위 여백
    public var placeHolderBottomPadding: CGFloat = 0                           //플레이스홀더 아래 여백
    public var placeHolderRightPadding: CGFloat = 5                            //플레이스홀더 오른쪽 여백
    public var placeHolderLeftPadding: CGFloat = 5                             //플레이스홀더 왼쪽 여백

    private weak var heightConstraint: NSLayoutConstraint?

    //MARK: - init    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        contentMode = .redraw
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidEndEditing), name: UITextView.textDidEndEditingNotification, object: self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - override
    override public func layoutSubviews() {
        super.layoutSubviews()
        let height = checkHeightConstraint()
        setNewHieghtConstraintConstant(with: height)

        if isAnimate {
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: { [weak self] in
                guard let self = self, let delegate = self.delegate as? TextViewMasterDelegate else { return }
                delegate.growingTextView?(growingTextView: self, willChangeHeight: height)
                self.scrollToBottom()
            }) { [weak self] _ in
                guard let self = self, let delegate = self.delegate as? TextViewMasterDelegate else { return }
                delegate.growingTextView?(growingTextView: self, didChangeHeight: height)
            }
        } else {
            guard let delegate = delegate as? TextViewMasterDelegate else { return }
            delegate.growingTextView?(growingTextView: self, willChangeHeight: height)
            self.scrollToBottom()
            delegate.growingTextView?(growingTextView: self, didChangeHeight: height)
        }
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        if text.isEmpty {
            drawPlaceHolder(rect)
        }
    }
}

//MARK: - custom func
extension TextViewMaster {
    private func checkHeightConstraint() -> CGFloat {
        let height = getHieght()
        
        if heightConstraint == nil {
            setHeightConstraint(with: height)
        }
        
        return height
    }

    private func setNewHieghtConstraintConstant(with constant: CGFloat) {
        guard constant != heightConstraint?.constant else { return }
        heightConstraint?.constant = constant
    }
    
    private func getHieght() -> CGFloat {
        let size = sizeThatFits(CGSize(width: bounds.size.width, height: CGFloat.greatestFiniteMagnitude))
        var height = size.height
        
        height = minHeight > 0 ? max(height, minHeight) : height
        height = maxHeight > 0 ? min(height, maxHeight) : height
        
        return height
    }
    
    private func setHeightConstraint(with height: CGFloat) {
        heightConstraint = self.heightAnchor.constraint(equalToConstant: height)
        addConstraint(heightConstraint!)
    }
    
    private func scrollToBottom() {
        let bottom = self.contentSize.height - self.bounds.size.height
        self.setContentOffset(CGPoint(x: 0, y: bottom), animated: false)
    }
    
    private func getPlaceHolderAttribues() -> [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment
        var attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeHolderColor,
            .paragraphStyle: paragraphStyle
        ]
        attributes[.font] = placeHolderFont
        
        return attributes
    }
    
    private func drawPlaceHolder(_ rect: CGRect) {
        let xValue = textContainerInset.left + placeHolderLeftPadding
        let yValue = textContainerInset.top + placeHolderTopPadding
        let width = rect.size.width - xValue - (textContainerInset.right + placeHolderRightPadding)
        let height = rect.size.height - yValue - (textContainerInset.bottom + placeHolderBottomPadding)
        let placeHolderRect = CGRect(x: xValue, y: yValue, width: width, height: height)

        guard let gc = UIGraphicsGetCurrentContext() else { return }
        gc.saveGState()
        defer { gc.restoreGState() }

        placeHolder.draw(in: placeHolderRect, withAttributes: getPlaceHolderAttribues())

    }
}

//MARK: - NotificationCenter
extension TextViewMaster {
    @objc private func textDidEndEditing(notification: Notification) {
        scrollToBottom()
    }
    
    @objc private func textDidChange(notification: Notification) {
        if let sender = notification.object as? TextViewMaster, sender == self {
            if maxLength > 0 && text.count > maxLength {
                let endIndex = text.index(text.startIndex, offsetBy: maxLength)
                text = String(text[..<endIndex])
                undoManager?.removeAllActions()
            }
            setNeedsDisplay()
        }
    }
}

extension TextViewMaster: TextViewMasterDelegate {
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard textView.hasText || text != "" else { return false }
        if let delegate = delegate as? TextViewMasterDelegate {
            guard let value = delegate.growingTextView?(growingTextView: self, shouldChangeTextInRange: range, replacementText: text) else { return false }
            return value
        }
        
        if text == "\n" {
            if let delegate = delegate as? TextViewMasterDelegate {
                delegate.growingTextViewShouldReturn?(growingTextView: self)
                return true
            } else {
                textView.resignFirstResponder()
                return false
            }
        }
        
        return true
    }
}
