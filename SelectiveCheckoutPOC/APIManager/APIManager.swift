//
//  APIManager.swift
//  SelectiveCheckoutPOC
//
//  Created by Sangat Baral on 21/09/21.
//

import Foundation
protocol CheckoutManagerDelegate {
    
    func didCheckoutUpdate(manager: CheckoutManager, model : TCCartDetailModel)
}
struct CheckoutManager {
    var delegate : CheckoutManagerDelegate?
    func performRequest(with urlString : String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    return
                }
                    guard let safeData = data else {
                        return
                    }
                    do {
                        self.delegate?.didCheckoutUpdate(manager: self , model: try JSONDecoder().decode(TCCartDetailModel.self, from: safeData))
                       
                    }
                    catch {
                        return
                    }
            }
            task.resume()
        }
    }
}
