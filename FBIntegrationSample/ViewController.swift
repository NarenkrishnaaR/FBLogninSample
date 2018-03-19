//
//  ViewController.swift
//  FBIntegrationSample
//
//  Created by Naren on 19/03/18.
//  Copyright © 2018 naren. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FacebookLogin
import FBSDKLoginKit

class ViewController: UIViewController {
  var dict : [String : AnyObject]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    fbLoginButton()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
    func fbLoginButton(){
      let fbLoginButton = LoginButton(readPermissions: [.publicProfile])
      fbLoginButton.center = view.center
      view.addSubview(fbLoginButton)
    }
  
  @IBAction func btnFbLoginFunc(_ sender: Any) {
    if NetworkReachable.isConnectedToNetwork() == true{
      let fbLoginManager = FBSDKLoginManager()
      fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
        if (error == nil){
          let fbloginresult : FBSDKLoginManagerLoginResult = result!
          if fbloginresult.grantedPermissions != nil {
            if(fbloginresult.grantedPermissions.contains("email"))
            {
              self.getFBUserData()
              fbLoginManager.logOut()
            }
          }
        }
      }
    }else{
      let alertController = UIAlertController(title: "Kidnly check your internet connection", message: "", preferredStyle: .alert)
      let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
      alertController.addAction(alertAction)
      self.present(alertController, animated: true, completion: nil)
    }
  }
  
  func getFBUserData(){
    if((FBSDKAccessToken.current()) != nil){
      FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
        if (error == nil){
          self.dict = result as! [String : AnyObject]
          print(result!)
          print(self.dict)
        }
      })
    }
  }
}

