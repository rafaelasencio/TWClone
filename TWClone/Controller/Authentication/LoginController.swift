//
//  LoginController.swift
//  TWClone
//
//  Created by RafaelAsencio on 30/11/2020.
//

import UIKit

class LoginController: UIViewController {
    
    //MARK: - Properties
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "TwitterLogo")
        return iv
    }()
    
    private var emailTextfield: UITextField = {
        let tf = Utilities().textfield(withPlaceholder: "Email")
        return tf
    }()
    
    private var passwordTextfield: UITextField = {
        let tf = Utilities().textfield(withPlaceholder: "Password", isSecureInput: true)
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
    
    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Log In", for: .normal)
        btn.setTitleColor(.twitterBlue, for: .normal)
        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let btn = Utilities().attributedButton("Don't have an account? ", "Sign Up")
        btn.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func handleLogin(){
        guard let email = emailTextfield.text, !email.isEmpty else { return }
        guard let password = passwordTextfield.text, !password.isEmpty else { return }
        AuthService.shared.logUserIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: error "+error.localizedDescription)
                return
            }
            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
            guard let tabController = window.rootViewController as? MainTabController else { return }
            tabController.authenticateUserAndConfigureUI()
            self.dismiss(animated: true, completion: nil)
            print("DEBUG: Successful log in")
        }
    }
    
    @objc func handleShowSignUp(){
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: - Helpers
    private func configureUI(){
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: self.view, topAnchor: self.view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                     paddingTop: 20, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
    }
}
