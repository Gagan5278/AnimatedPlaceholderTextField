//
//  PlaceholderTextfieldView.swift
//  PlaceholderTextfield
//
//  Created by Gagan  Vishal on 6/12/20.
//  Copyright © 2020 Gagan  Vishal. All rights reserved.
//

import UIKit

@IBDesignable class PlaceholderView: UIView {
    //Array to handle constraint apllied on placeHolderLabel
    private var customConstraints = [NSLayoutConstraint]()
    //IBInspectable for setting UITextField placeholder
    @IBInspectable var placeHolderString: String = "Enter name"{
        didSet {
            self.placeHolderLabel.text = placeHolderString
        }
    }
    //IBInspectable  text color on UITextField and on UILabel
    @IBInspectable var textFieldColor: UIColor = .gray {
        didSet {
            self.textField.textColor = textFieldColor
            self.placeHolderLabel.textColor = textFieldColor
        }
    }
    //....Font Size setup
    fileprivate var _fontSize:CGFloat = 18.0
    //IBInspectable Set font size for UITextField and UILabel. defualt is 18.0
    @IBInspectable var font:CGFloat
    {
        set
        {
            _fontSize = newValue
            self.textField.font = UIFont(name: _fontName, size: _fontSize)
            self.placeHolderLabel.font = self.textField.font
        }
        get
        {
            return _fontSize
        }
    }
    //......font name setup
    fileprivate var _fontName:String = "Helvetica"
    //IBInspectable Set font name in Storyboard. Default is 'Helvetica'
    @IBInspectable var fontName:String
    {
        set
        {
            _fontName = newValue
            self.textField.font = UIFont(name: _fontName, size: _fontSize)
            self.placeHolderLabel.font = self.textField.font
        }
        get
        {
            return _fontName
        }
    }
    //UITextfield under line color
    @IBInspectable var bottomLineColor: UIColor = .gray {
        didSet {
            self.textField.setUnderlineColor(color: bottomLineColor)
        }
    }
   //UILabel which will act as place holder for UITextField
   lazy var placeHolderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = self.placeHolderString
        label.textColor = .gray
        return label
    }()
    
    //Under line UITextfield
    var textField: CustomTextfiled = {
        let textField = CustomTextfiled(frame: .zero)
        textField.addTarget(self, action: #selector (textFieldDidChange(textField:)), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    //MARK:- View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewSetup()
    }
    
    //MARK:- view setup
    private func viewSetup() {
        self.backgroundColor = .clear
        self.textField.delegate = self
        self.addSubview(textField)
        self.addSubview(placeHolderLabel)
        //1.
        textField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        textField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.70).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        //2.
        self.addConstraintOnLabel()
    }
    
    //MARK:- TextDid change target textfield
    @objc func textFieldDidChange(textField: CustomTextfiled) {
        if textField.text!.isEmpty {
            self.addConstraintOnLabel()
        }
        else {
            self.addConstraintOnLabel(onTextField: false)
        }
    }
    
    //MARK:- Add constraint on UILable
    private func addConstraintOnLabel(onTextField: Bool = true) {
        self.clearConstraints()
        if onTextField {
            let constraints = [
                placeHolderLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
                placeHolderLabel.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
                placeHolderLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.30)
            ]
            activate(constraints: constraints)
            //reset Label font to textField font
            placeHolderLabel.font = self.textField.font
        }
        else {
            let constraints = [
                placeHolderLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
                placeHolderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 2.0),
                placeHolderLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.30)
            ]
            self.activate(constraints: constraints)
            
            self.setNeedsUpdateConstraints()
            UIView.animate(withDuration: 0.25) {
                self.layoutIfNeeded()
            }
            //Decrease Label font size by 2
            placeHolderLabel.font = UIFont(name: _fontName, size: _fontSize - 2.0)
        }
    }
    
    //MARK:- Activate on constraints placeHolderLabel
    private func activate(constraints: [NSLayoutConstraint]) {
        customConstraints.append(contentsOf: constraints)
        customConstraints.forEach { $0.isActive = true }
    }
    
    //MARK:- Remove added constraints
    private func clearConstraints() {
        customConstraints.forEach { $0.isActive = false }
        customConstraints.removeAll()
    }

}

//MARK:- UITextfield delegate
extension PlaceholderView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Force wrap would not crash
        if textField.text!.isEmpty {
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Force wrap would not crash
        if textField.text!.isEmpty {
            self.addConstraintOnLabel()
        }
        else {
            self.addConstraintOnLabel(onTextField: false)
        }
    }

}
