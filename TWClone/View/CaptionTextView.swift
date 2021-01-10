//
//  CaptionTextView.swift
//  TWClone
//
//  Created by RafaelAsencio on 03/12/2020.
//

import UIKit

class CaptionTextView: UITextView {
    
    //MARK: - Properties
    
    let placeholderLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = .darkGray
        lbl.text = "What's happening?"
        return lbl
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        backgroundColor = .white
        font = UIFont.systemFont(ofSize: 16)
        isScrollEnabled = false
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top:topAnchor,left: leftAnchor, paddingTop: 8, paddingLeft: 4)
        
        //Handle events when text starts changing
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    @objc func handleTextInputChange(){
        placeholderLabel.isHidden = !text.isEmpty
    }
    
}
