//
//  TBSelectiveCheckoutInteractor.swift
//  SelectiveCheckoutPOC
//
//  Created by Sangat Baral on 21/09/21.
//

import Foundation
import UIKit
class CartItem {
    
    private var item: TCProduct
    
    var isSelected = false
    
    var title: String {
        return item.productName ?? ""
    }
    var image: String {
        return item.imageURL ?? ""
    }
    var price: Int {
        return item.price ?? 0
    }
    var qty: String {
        return item.qtySelectedByUser ?? ""
    }
    
    var productCode: String {
        return item.productcode ?? ""
    }
    
    var ussid: String {
        return item.ussid ?? ""
    }
    
    init(item: TCProduct) {
        self.item = item
    }
}
class TBCheckoutInteractor: ITBCheckoutInteractor, CheckoutManagerDelegate {
    func didCheckoutUpdate(manager: CheckoutManager, model: TCCartDetailModel) {
        self.cartModel = model
        items = (cartModel?.products?.map { CartItem(item: $0) })!
    }
    
    weak var interactorDelegate: TBCheckoutInteractorDelegate?
    var cartModel: TCCartDetailModel?
    var items = [CartItem]()
    var checkoutManager =   CheckoutManager()
    
    var didToggleSelection: ((_ hasSelection: Bool) -> ())? {
        didSet {
            didToggleSelection?(!selectedItems.isEmpty)
        }
    }
    
    var selectedItems: [CartItem] {
        return items.filter { return $0.isSelected }
    }
    
    func triggerGetBagItems(onCompletion handler: ((TCCartDetailModel?) -> Void)?) {
        checkoutManager.performRequest(with: "https://preprod2.tataunistore.com/marketplacewebservices/v2/mpl/users/6061845705/carts/15481123719086096-195695121/cartDetails?access_token=69048833-013b-4450-b89b-55d198d8be32&isPwa=true&isUpdatedPwa=true&platformNumber=11&pincode=110001&channel=web&isMDE=true&isDuplicateImei=true")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            handler?(nil)
        }
        
    }
    
    func prepareTableViewCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        if let cell = tableView.dequeueReusableCell(withIdentifier: myCell.identifier, for: indexPath) as? myCell {
            cell.item = items[indexPath.row]
            if items[indexPath.row].isSelected {
                if !cell.isSelected {
                    tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                }
            } else {
                if cell.isSelected {
                    tableView.deselectRow(at: indexPath, animated: false)
                }
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func prepareDidSelect(tableView: UITableView, indexPath: IndexPath) {
        items[indexPath.row].isSelected = true

        didToggleSelection?(!selectedItems.isEmpty)
    }
    
    func prepareDidDeSelect(tableView: UITableView, indexPath: IndexPath) {
        items[indexPath.row].isSelected = false

        didToggleSelection?(!selectedItems.isEmpty)
    }
    
    func getRowCount(section: Int) -> Int {
        return items.count
    }
    
    func getNumberOfSections() -> Int {
        return 1
    }
    
    func getCartModel() -> TCCartDetailModel? {
        return self.cartModel
    }
    
}
