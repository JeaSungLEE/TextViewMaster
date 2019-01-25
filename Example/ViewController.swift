//
//  ViewController.swift
//  Example
//
//  Created by jeasung.lee on 2017. 12. 12..
//  Copyright © 2017년 jeasungLEE. All rights reserved.
//

import UIKit
import TextViewMaster

class ViewController: UIViewController {
    var bottomConstraint: NSLayoutConstraint?
    override func viewDidLoad() {
        super.viewDidLoad()
        let inputView = UIView()
        let textViewMaster = TextViewMaster()
        let sendLabel = UILabel()
        
        inputView.backgroundColor = .gray
        sendLabel.text = "send"
        
        textViewMaster.delegate = self
        textViewMaster.layer.cornerRadius = 5
        textViewMaster.isAnimate = true                                               //에니메이션 사용여부
        textViewMaster.maxLength = 200                                                //최대 글자수
        textViewMaster.maxHeight = 500                                                //최대 높이 제한
        textViewMaster.placeHolder = "메세지를 입력해주세요."                               //플레이스홀더
        textViewMaster.placeHolderColor = UIColor(white: 0.8, alpha: 1.0)             //플레이스홀더 색상
        textViewMaster.font = UIFont.systemFont(ofSize: 17)
     
        inputView.translatesAutoresizingMaskIntoConstraints = false
        textViewMaster.translatesAutoresizingMaskIntoConstraints = false
        sendLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(inputView)
        inputView.addSubview(textViewMaster)
        inputView.addSubview(sendLabel)

        inputView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        inputView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomConstraint = inputView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomConstraint?.isActive = true
        
        sendLabel.bottomAnchor.constraint(equalTo: inputView.bottomAnchor).isActive = true
        sendLabel.trailingAnchor.constraint(equalTo: inputView.trailingAnchor, constant: -8).isActive = true
        sendLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        sendLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        textViewMaster.topAnchor.constraint(equalTo: inputView.topAnchor, constant: 8).isActive = true
        textViewMaster.leadingAnchor.constraint(equalTo: inputView.leadingAnchor, constant: 8).isActive = true
        textViewMaster.trailingAnchor.constraint(equalTo: sendLabel.leadingAnchor, constant: -8).isActive = true
        textViewMaster.bottomAnchor.constraint(equalTo: inputView.bottomAnchor, constant: -8).isActive = true
    
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        view.addGestureRecognizer(tapGesture)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillChangeFrame(_ notification: Notification) {
        let endFrame = ((notification as NSNotification).userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
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

extension ViewController: TextViewMasterDelegate {
    func growingTextView(growingTextView: TextViewMaster, willChangeHeight height: CGFloat) {
        self.view.layoutIfNeeded()
    }
}

