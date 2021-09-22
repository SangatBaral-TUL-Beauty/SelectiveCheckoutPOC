//
//  TBSelectiveCheckoutConfiguration.swift
//  SelectiveCheckoutPOC
//
//  Created by Sangat Baral on 21/09/21.
//

import UIKit

class TBCheckoutConfiguration {
    
    static func setup() -> UIViewController {
        let storyboard = UIStoryboard(name: "TBCheckout", bundle: Bundle.main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "TBCheckoutViewController") as? TBCheckoutViewController else {
            return UIViewController()
        }
            let interactor = TBCheckoutInteractor()
            interactor.checkoutManager.delegate = interactor
            interactor.interactorDelegate = controller
            controller.interactor = interactor
            return controller
            
    }
}
