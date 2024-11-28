//
//  SignUpViewController.swift
//  unitTestExample
//
//  Created by Turker Alan on 27.10.2024.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    weak var signUpPresenter: SignUpPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if signUpPresenter == nil {
            let signUpModelValidator = SignUpFormModelValidator()
            let webService = SignUpWebService(urlString: SignUpConstants.signUpUrlString)
            
            signUpPresenter = SignUpPresenter(formModelValidator: signUpModelValidator,
                                              signUpWebService: webService,
                                              delegate: self)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapSignUpButton(_ sender: UIButton) {
        let formModel = SignUpFormModel(firstName: firstNameTextField.text ?? "",
                                        lastName: "",
                                        email: "",
                                        password: "",
                                        repeatPassword: "")
        signUpPresenter?.processUserSignUp(formModel: formModel)
    }
    

}
extension SignUpViewController: SignUpViewDelegateProtocol {
    func successfullSignUp() {
        //TODO:
    }
    
    func errorHandler(error: SignUpError) {
        //TODO: 
    }
    
    
}
