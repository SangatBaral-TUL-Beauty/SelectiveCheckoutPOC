//
//  ViewController.swift
//  SelectiveCheckoutPOC
//
//  Created by Sangat Baral on 21/09/21.
//

import UIKit

class ViewController: UIViewController {
        
    @IBOutlet weak var myBagButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        myBagButton.layer.cornerRadius = 12
    }
    
    @IBAction func next(_ sender: Any) {
        let controller = TBCheckoutConfiguration.setup()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
