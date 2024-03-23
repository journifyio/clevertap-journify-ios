//
//  WriteKeyVC.swift
//  SwiftExample
//
//  Created by Bendnaiba on 2/13/23.
//

import UIKit
import Journify
import CleverTapSDK
import CleverTapDestination

class WriteKeyVC: UIViewController {
    
    @IBOutlet weak var writeKeyTextField: UITextField!
    @IBOutlet weak var cleverAccoutIDTextField: UITextField!
    @IBOutlet weak var cleverTokenTextField: UITextField!
    @IBOutlet weak var cleverRegionTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let writeKey = UserDefaults.standard.object(forKey: "WriteKey") as? String {
            self.writeKeyTextField.text = writeKey
        }
        if let cleverAccountID = UserDefaults.standard.object(forKey: "CleverAccountID") as? String {
            self.cleverAccoutIDTextField.text = cleverAccountID
        }
        if let cleverToken = UserDefaults.standard.object(forKey: "CleverToken") as? String {
            self.cleverTokenTextField.text = cleverToken
        }
        if let cleverRegion = UserDefaults.standard.object(forKey: "CleverRegion") as? String {
            self.cleverRegionTextField.text = cleverRegion
        }
    }

    @IBAction func StartTapped(_ sender: Any) {
        guard let writeKey = self.writeKeyTextField.text,
              let cleverAccountID = self.cleverAccoutIDTextField.text,
              let cleverToken = self.cleverTokenTextField.text else {
            startButton.shake()
            return
        }
        guard writeKey.count > 10 && cleverAccountID.count > 10 && cleverToken.count > 10 else {
            startButton.shake()
            return
        }
        let cleverRegion = self.cleverRegionTextField.text
        UserDefaults.standard.set(writeKey, forKey: "WriteKey")
        UserDefaults.standard.set(cleverAccountID, forKey: "CleverAccountID")
        UserDefaults.standard.set(cleverToken, forKey: "CleverToken")
        UserDefaults.standard.set(cleverRegion, forKey: "CleverRegion")

        UserDefaults.standard.synchronize()
        initJournify(writeKey: writeKey)
        initCleverTap(cleverAccountID: cleverAccountID, cleverToken: cleverToken, cleverRegion: cleverRegion)
        pushViewController()
    }
    
    func initJournify(writeKey: String) {
        //init Journify
        let configuration = Configuration(writeKey: writeKey)
            .trackApplicationLifecycleEvents(true)
            .flushInterval(10)
        Journify.debugLogsEnabled = true
        Journify.setup(with: configuration)
    }
    
    func initCleverTap(cleverAccountID: String, cleverToken: String, cleverRegion: String?) {
        //Setup cleverTapDestination
        CleverTap.setDebugLevel(CleverTapLogLevel.debug.rawValue)
        let cleverTapDestination = CleverTapDestination(accountID: cleverAccountID, token: cleverToken, region: cleverRegion)
        Journify.shared().add(plugin: cleverTapDestination)
    }
    
    func pushViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
        self.navigationController?.show(viewController, sender: self)
    }
    
}

extension WriteKeyVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

