//
//  LoginViewController.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginViaWebsiteButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "completeLogin", sender: nil)
        TMDBClient.getRequestToken(completion: handleRequestTokenResponse(success:error:))
        
    }
    
    @IBAction func loginViaWebsiteTapped() {
        performSegue(withIdentifier: "completeLogin", sender: nil)
    }
    
    func handleRequestTokenResponse(success: Bool, error: Error?){
        if success{
            print(TMDBClient.Auth.requestToken)
            DispatchQueue.main.async {
                TMDBClient.login(username: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", completion: self.handleLoginResponse(success:error:))
            }
         
        }
    }
    
    func handleLoginResponse(success: Bool, error: Error?){ // burdan sonra handleRequestTokenResponse icinde cagiriyorum. loginTapped icinde degil. Ayrica main thread de calismamasi icin async icinde yaziyorum.
        
        
        if success{
            print(TMDBClient.Auth.requestToken)
            TMDBClient.createSessionId( completion: handleSessionResponse(success:error:))
            
        }
    }
    
    func handleSessionResponse(success: Bool, error: Error?){ //burdan sonra da handleLoginResponse icinde cagiriyorum. cunku login dogru calistiktan sonra sessionid yaratilmasini bekliyorum.
        if success{
            print(TMDBClient.Auth.sessionId)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
            }
        }
    }
    
}
