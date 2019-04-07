//
//  UserLoginViewController.swift
//  WrapItUpPayments
//
//  Created by Derik Gagnon on 3/29/19.
//  Copyright © 2019 Derik Gagnon. All rights reserved.
//

import UIKit
import FirebaseUI

class UserLoginViewController: UIViewController, FUIAuthDelegate {
    
    fileprivate(set) var auth:Auth?
    fileprivate(set) var authUI: FUIAuth? //only set internally but get externally
    fileprivate(set) var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        guard let authError = error else {
            print("Login Successful")
            return
        }
        
        let errorCode = UInt((authError as NSError).code)
        
        switch errorCode {
        case FUIAuthErrorCode.userCancelledSignIn.rawValue:
            print("User cancelled sign-in");
            break
            
        default:
            let detailedError = (authError as NSError).userInfo[NSUnderlyingErrorKey] ?? authError
            print("Login error: \((detailedError as! NSError).localizedDescription)");
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(Auth.auth().currentUser?.displayName ?? "name")
        try! Auth.auth().signOut()

        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view, typically from a nib.
        self.auth = Auth.auth()
        self.authUI = FUIAuth.defaultAuthUI()
        self.authUI?.delegate = self
        self.authUI?.providers = [FUIEmailAuth(), FUIGoogleAuth()]
        
        
        self.authStateListenerHandle = self.auth?.addStateDidChangeListener { (auth, user) in
            guard user != nil else {
                //self.loginAction(sender: self)
                return
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //print(Auth.auth().currentUser?.displayName ?? "name")
        if Auth.auth().currentUser != nil {
            print("Inside If")
            print(Thread.isMainThread)
            self.performSegue(withIdentifier: "LoginSegue", sender: self)
        }
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        // Present the default login view controller provided by authUI
        let authViewController = authUI?.authViewController();
        print("authenticator")
        self.present(authViewController!, animated: true, completion: nil)
        
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
