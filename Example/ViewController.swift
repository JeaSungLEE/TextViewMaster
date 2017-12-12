//
//  ViewController.swift
//  Example
//
//  Created by jeasung.lee on 2017. 12. 12..
//  Copyright © 2017년 jeasungLEE. All rights reserved.
//

import UIKit
import JSGrowingTextView

class ViewController: UIViewController {
    var bottomConstraint: NSLayoutConstraint?
    override func viewDidLoad() {
        super.viewDidLoad()
        let inputView = UIView()
        let growingTextView = JSGrowingTextView()
        let sendLabel = UILabel()
        
        inputView.backgroundColor = .gray
        sendLabel.text = "send"
        
        growingTextView.delegate = self
        growingTextView.layer.cornerRadius = 5
        growingTextView.isAnimate = true                                               //에니메이션 사용여부
        growingTextView.maxLength = 200                                                //최대 글자수
        growingTextView.maxHeight = 500                                                //최대 높이 제한
        growingTextView.placeHolder = "메세지를 입력해주세요."                               //플레이스홀더
        growingTextView.placeHolderColor = UIColor(white: 0.8, alpha: 1.0)             //플레이스홀더 색상
        growingTextView.font = UIFont.systemFont(ofSize: 17)
     
        inputView.translatesAutoresizingMaskIntoConstraints = false
        growingTextView.translatesAutoresizingMaskIntoConstraints = false
        sendLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(inputView)
        inputView.addSubview(growingTextView)
        inputView.addSubview(sendLabel)

        inputView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        inputView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomConstraint = inputView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomConstraint?.isActive = true
        
        sendLabel.bottomAnchor.constraint(equalTo: inputView.bottomAnchor).isActive = true
        sendLabel.trailingAnchor.constraint(equalTo: inputView.trailingAnchor, constant: -8).isActive = true
        sendLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        sendLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        growingTextView.topAnchor.constraint(equalTo: inputView.topAnchor, constant: 8).isActive = true
        growingTextView.leadingAnchor.constraint(equalTo: inputView.leadingAnchor, constant: 8).isActive = true
        growingTextView.trailingAnchor.constraint(equalTo: sendLabel.leadingAnchor, constant: -8).isActive = true
        growingTextView.bottomAnchor.constraint(equalTo: inputView.bottomAnchor, constant: -8).isActive = true
    
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        view.addGestureRecognizer(tapGesture)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillChangeFrame(_ notification: Notification) {
        let endFrame = ((notification as NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        bottomConstraint?.constant = -(view.bounds.height - endFrame.origin.y)
        self.view.layoutIfNeeded()
    }

    @objc func tapGestureHandler() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: JSGrowingTextViewDelegate {
    func growingTextView(growingTextView: JSGrowingTextView, willChangeHeight height: CGFloat) {
        self.view.layoutIfNeeded()
    }
}

