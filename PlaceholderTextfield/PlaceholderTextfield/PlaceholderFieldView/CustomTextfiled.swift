//
//  CustomTextfiled.swift
//  PlaceholderTextfield
//
//  Created by Gagan  Vishal on 6/12/20.
//  Copyright © 2020 Gagan  Vishal. All rights reserved.
//

import UIKit

class CustomTextfiled: UITextField {
    //color for bottom line. Default is Gray
    private let defaultUnderlineColor = UIColor.gray
    //view addeed on bottom of UITextfield
    private let bottomLine = UIView()
    
    //MARK:- View Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addUnderLineView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addUnderLineView()
    }
    
    //MARK:- Underline setup
    private func addUnderLineView() {
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        //1. set border to none
        borderStyle = .none
        //2. Set placeholder empty
        placeholder = ""
        //3. set deafult bottom color
        self.setDefaultUnderlineColor()
        //4. Add bottom view on Textfield
        self.addSubview(bottomLine)
        //5. Autolayout setup for bottomLine
        bottomLine.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        bottomLine.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomLine.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    //MARK:- Set color from outside. Default is blue
    public func setUnderlineColor(color: UIColor = .blue) {
        bottomLine.backgroundColor = color
    }
    
    //MARK:- Set default color
    private func setDefaultUnderlineColor() {
        bottomLine.backgroundColor = defaultUnderlineColor
    }
}
