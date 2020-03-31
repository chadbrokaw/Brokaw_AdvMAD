//
//  AddDogController.swift
//  dogs
//
//  Created by Chad Brokaw on 3/30/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import UIKit

class AddDogController: UIViewController {
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var fluffinessTextField: UITextField!
    @IBOutlet weak var dogTypeTextField: UITextField!
    
    var dogType: String?
    var fluffiness: Double?
    var notes: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(AddDogController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
        // Do any additional setup after loading the view.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    @objc func didTapView(){
      self.view.endEditing(true)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "SaveSegue" {
            if dogTypeTextField.text?.isEmpty == false {
                dogType = dogTypeTextField.text
            }
            else {
                print("Dog type not given")
            }
            if fluffinessTextField.text?.isEmpty == false {
                fluffiness = Double(fluffinessTextField.text!)
            }
            else {
                print("Fluffiness not given")
            }
            if notesTextView.text?.isEmpty == false {
                notes = notesTextView.text
            }
            else {
                print("Notes not given")
            }
        }
    }
    

}
