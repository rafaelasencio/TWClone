//
//  RegistrationController.swift
//  TWClone
//
//  Created by RafaelAsencio on 30/11/2020.
//

import UIKit
import Firebase

class RegistrationController: UIViewController {
    
    //MARK: - Properties
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
    private let plusPhotoButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "plus_photo"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        return btn
    }()
    
    private var emailTextfield: UITextField = {
        let tf = Utilities().textfield(withPlaceholder: "Email")
        return tf
    }()
    
    private var passwordTextfield: UITextField = {
        let tf = Utilities().textfield(withPlaceholder: "Password", isSecureInput: true)
        return tf
    }()
    
    private var fullnameTextfield: UITextField = {
        let tf = Utilities().textfield(withPlaceholder: "Full Name")
        return tf
    }()
    
    private var usernameTextfield: UITextField = {
        let tf = Utilities().textfield(withPlaceholder: "Username")
        return tf
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities().inputContrainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textfield: emailTextfield)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilities().inputContrainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textfield: passwordTextfield)
        return view
    }()
    
    private lazy var fullnameContainerView: UIView = {
        let view = Utilities().inputContrainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textfield: fullnameTextfield)
        return view
    }()
    
    private lazy var usernameContainerView: UIView = {
        let view = Utilities().inputContrainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textfield: usernameTextfield)
        return view
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let btn = Utilities().attributedButton("Already have an account? ", "Log In")
        btn.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return btn
    }()
    
    private let registrationButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(.twitterBlue, for: .normal)
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    //MARK: - Selectors
    @objc func handleShowLogin(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleAddProfilePhoto(){
        self.present(imagePicker, animated: true)
    }
    
    @objc func handleRegistration(){
        guard let profileImage = profileImage else { return }
        guard let email = emailTextfield.text, !email.isEmpty else { return }
        guard let password = passwordTextfield.text, !password.isEmpty else { return }
        guard let fullname = fullnameTextfield.text, !fullname.isEmpty else { return }
        guard let username = usernameTextfield.text, !username.isEmpty else { return }
        
        let authCredentials = AuthCredentials(profileImage: profileImage, email: email, password: password,
                                              fullname: fullname, username: username)
        AuthService.shared.registerUser(authCredentials) { error, ref in
            if let error = error {
                print("DEBUB: error "+error.localizedDescription)
                return
            }
            print("DEBUG: successfully updated user information")
        }
    }
    
    //MARK: - Helpers
    private func configureUI(){
        setImagePicker()
        view.backgroundColor = .twitterBlue
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        plusPhotoButton.setDimensions(width: 128, height: 128)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   fullnameContainerView,
                                                   usernameContainerView,
                                                   registrationButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        stack.centerX(inView: view)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
    }
    
    private func setImagePicker(){
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
}

//MARK: - UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.plusPhotoButton.styleRound(withCornerRadius: 128)
        
        self.dismiss(animated: true)
    }
}
