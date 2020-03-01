//
//  DetailViewController.swift
//  dogs
//
//  Created by Chad Brokaw on 2/29/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBAction func share(_ sender: Any) {
        var imageArray = [UIImage]()
        imageArray.append(imageView.image!)
        let shareModal = UIActivityViewController(activityItems: imageArray, applicationActivities: nil)
        
        shareModal.modalPresentationStyle = .popover
        present(shareModal, animated: true, completion: nil)
    }
    
    var imageName: String?
    
    override func viewWillAppear(_ animated: Bool) {
        if let name = imageName {
            imageView.image = UIImage(named: name)
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
