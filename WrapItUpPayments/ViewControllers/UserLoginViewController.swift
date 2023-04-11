//
//  UserLoginViewController.swift
//  WrapItUpPayments
//
//  Created by Derik Gagnon on 3/29/19.
//  Copyright © 2019 Derik Gagnon. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseAuthUI
import SDWebImage
import FirebaseEmailAuthUI
import FirebaseGoogleAuthUI

class UserLoginViewController: UIViewController, FUIAuthDelegate {
    
    fileprivate(set) var auth:Auth?
    fileprivate(set) var authUI: FUIAuth? //only set internally but get externally
    fileprivate(set) var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        // jump out once we have a valid user
        guard let authError = error else {
            print("Login Successful")
            return
        }
        
        let errorCode = UInt((authError as NSError).code)
        
        // if user cancels login, error here
        switch errorCode {
        case FUIAuthErrorCode.userCancelledSignIn.rawValue:
            print("User cancelled sign-in");
            break
            
        // error if not logged in
        default:
            let detailedError = (authError as NSError).userInfo[NSUnderlyingErrorKey] ?? authError
            print("Login error: \((detailedError as! NSError).localizedDescription)");
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
        
        // Force a signout so that a different user could potentially sign back in
        // Useful if the users have different accounts for different time menus.
        try! Auth.auth().signOut()
        
        // Setting up authentication listener
        self.auth = Auth.auth()
        self.authUI = FUIAuth.defaultAuthUI()
        self.authUI?.delegate = self
        self.authUI?.providers = [FUIEmailAuth(), FUIGoogleAuth()]
        
        
        self.authStateListenerHandle = self.auth?.addStateDidChangeListener { (auth, user) in
            // Jumps out when the state changes to valid user
            guard user != nil else {
                return
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Once we have valid user, go to next view
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "LoginSegue", sender: self)
        }
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        // Present the default login view controller provided by authUI
        let authViewController = authUI?.authViewController();
        self.present(authViewController!, animated: true, completion: nil)
        
    }

}
