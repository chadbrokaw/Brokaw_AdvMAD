//
//  SignInViewController.swift
//  dogs
//
//  Created by Chad Brokaw on 3/30/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import UIKit
import FirebaseUI

class SignInViewController: UIViewController, FUIAuthDelegate {
    
    let authUI = FUIAuth.defaultAuthUI()

    @IBAction func loginAction(_ sender: Any) {
        print("Trying to present view controller")

        let authViewController = authUI?.authViewController()

        present(authViewController!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        authUI?.delegate = self
        let providers: [FUIAuthProvider] = [
          FUIGoogleAuth()
        ]

        authUI?.providers = providers

        // Do any additional setup after loading the view.
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        if user != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "rootNav")
            viewController.modalPresentationStyle = .fullScreen

            present(viewController, animated: true, completion: nil)
        } else {
            print(error!.localizedDescription)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
