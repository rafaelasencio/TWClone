//
//  Utilities.swift
//  TWClone
//
//  Created by RafaelAsencio on 30/11/2020.
//

import UIKit

class Utilities {
    
    func inputContrainerView(withImage image: UIImage, textfield: UITextField)-> UIView{
        let view = UIView()
        let iv = UIImageView()

        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.image = image
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor, paddingLeft: 8)
        iv.centerY(inView: view)
        iv.setDimensions(width: 24, height: 24)
        view.addSubview(textfield)
        textfield.anchor(left: iv.rightAnchor, bottom: iv.bottomAnchor, right: view.rightAnchor,
                         paddingLeft: 8, paddingRight: 8)
        textfield.centerY(inView: view)
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,
                           paddingLeft: 8, paddingBottom: 8, height: 0.75)
        return view
    }
    
    func textfield(withPlaceholder placeholder: String, isSecureInput: Bool? = nil)-> UITextField {
        let tf = UITextField()
        tf.textColor = .white
        tf.isSecureTextEntry = isSecureInput != nil ? true : false
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return tf
    }
    
    func attributedButton(_ firstPart: String, _ secondPart: String)-> UIButton{
        let btn = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSMutableAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
        btn.setAttributedTitle(attributedTitle, for: .normal)
        return btn
    }
}

