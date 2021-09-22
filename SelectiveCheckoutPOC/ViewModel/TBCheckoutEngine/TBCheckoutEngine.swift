//
//  TBCheckoutEngine.swift
//  SelectiveCheckoutPOC
//
//  Created by Sangat Baral on 21/09/21.
//

import Foundation

struct TBCheckoutEngine {
    internal static func startBooting(interactor: ITBCheckoutInteractor?) {
        let group = DispatchGroup()

        group.enter()
            interactor?.triggerGetBagItems(onCompletion: { _ in
                group.leave()
            })
        group.notify(queue: .main) {
            interactor?.interactorDelegate?.didReloadBaseView()
        }
    }
}
