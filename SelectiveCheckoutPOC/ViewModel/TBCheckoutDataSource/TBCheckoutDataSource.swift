//
//  TBCheckoutDataSource.swift
//  SelectiveCheckoutPOC
//
//  Created by Sangat Baral on 21/09/21.
//

import Foundation
import UIKit

protocol ITBCheckoutInteractor: TBCheckoutTableInteractor, TBCheckoutWorkerDataSource   {
    var interactorDelegate: TBCheckoutInteractorDelegate? {get set}
    func triggerGetBagItems(onCompletion handler: ((TCCartDetailModel?) -> Void)?)
}

protocol TBCheckoutInteractorDelegate: NSObjectProtocol {
    func didReloadBaseView()
    func pushNavigationController(controller: UIViewController)
}

protocol TBCheckoutTableInteractor {
    func prepareTableViewCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell?
    func prepareDidSelect(tableView: UITableView, indexPath: IndexPath)
    func prepareDidDeSelect(tableView: UITableView, indexPath: IndexPath)
    func getRowCount(section: Int) -> Int
    func getNumberOfSections() -> Int
}
protocol TBCheckoutWorkerDataSource {
    func getCartModel() -> TCCartDetailModel?
}
// MARK: - TCCartDetailModel
public struct TCCartDetailModel: Codable {
    public let type, status: String?
    public var cartAmount: TCCartAmount?
    public let cartGUID: String?
    public let count: Int?
    public let isBankPromotionApplied, isBundlingItemsAvailable, isBuyNowCart: Bool?
    public let maxAllowed: Int?
    public let products: [TCProduct]?
    public let shippingPromoMessage: String?
    public let totalExchangeAmount: TCTotalExchangeAmount?

    enum CodingKeys: String, CodingKey {
        case type, status, cartAmount
        case cartGUID = "cartGuid"
        case count, isBankPromotionApplied, isBundlingItemsAvailable, isBuyNowCart, maxAllowed, products, shippingPromoMessage, totalExchangeAmount
    }
}

// MARK: - TCCartAmount
public struct TCCartAmount: Codable {
    public let bagTotal, couponDiscountAmount , comboDiscountAmount, paybleAmount, shippingCharge: TCTotalExchangeAmount?
    public let totalDiscountAmount: TCTotalExchangeAmount?
}

// MARK: - TCTotalExchangeAmount
public struct TCTotalExchangeAmount: Codable {
    public let commaFormattedValue, commaFormattedValueNoDecimal, currencyISO, currencySymbol: String?
    public let doubleValue: Double?
    public let formattedValue, formattedValueNoDecimal, priceType: String?
    public let value: Double?

    enum CodingKeys: String, CodingKey {
        case commaFormattedValue, commaFormattedValueNoDecimal
        case currencyISO = "currencyIso"
        case currencySymbol, doubleValue, formattedValue, formattedValueNoDecimal, priceType, value
    }

}

// MARK: - TCProduct
public struct TCProduct: Codable {
    public let ussid: String?
    public let availableStockCount: Int?
    public let bundlingSuggestionAvailable: Bool?
    public let categoryHierarchy: [TCCategoryHierarchy]?
    public let categoryL4Code: String?
    public let clickable: Bool?
    public let color: String?
    public let comboDiscountAppliedQuantity: Int?
    public let elligibleDeliveryMode: [TCElligibleDeliveryMode]?
    public let entryNumber, fullfillmentType, imageURL: String?
    public let isExchangeAllow: Bool?
    public let isGiveAway, isLuxury: String?
    public let isOutOfStock: Bool?
    public let maxQuantityAllowed, offerPrice: String?
    public let pinCodeResponse: TCPinCodeResponse?
    public let price: Int?
    public let productBrand, productBrandCode, productCategoryID, productName: String?
    public let productcode, qtySelectedByUser, rootCategory, sellerID: String?
    public let sellerName, size: String?

    enum CodingKeys: String, CodingKey {
        case ussid = "USSID"
        case availableStockCount, bundlingSuggestionAvailable, categoryHierarchy, categoryL4Code, clickable, color, comboDiscountAppliedQuantity, elligibleDeliveryMode, entryNumber, fullfillmentType, imageURL, isExchangeAllow, isGiveAway, isLuxury, isOutOfStock, maxQuantityAllowed, offerPrice, pinCodeResponse, price, productBrand, productBrandCode
        case productCategoryID = "productCategoryId"
        case productName, productcode, qtySelectedByUser, rootCategory
        case sellerID = "sellerId"
        case sellerName, size
    }
}

// MARK: - TCCategoryHierarchy
public struct TCCategoryHierarchy: Codable {
    public let categoryID, categoryName: String?

    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryName = "category_name"
    }
}

// MARK: - TCElligibleDeliveryMode
public struct TCElligibleDeliveryMode: Codable {
    public let charge: TCCharge?
    public let code, desc, name: String?
    public let priority: Int?
}

// MARK: - TCCharge
public struct TCCharge: Codable {
    public let currencyISO: String?
    public let doubleValue: Int?
    public let formattedValue, formattedValueNoDecimal, priceType: String?
    public let value: Int?

    enum CodingKeys: String, CodingKey {
        case currencyISO = "currencyIso"
        case doubleValue, formattedValue, formattedValueNoDecimal, priceType, value
    }
}

// MARK: - TCPinCodeResponse
public struct TCPinCodeResponse: Codable {
    public let city, cod: String?
    public let exchangeServiceable: Bool?
    public let isCODLimitFailed: String?
    public let isPickupAvailableForExchange: Bool?
    public let isPrepaidEligible, isServicable, ussid: String?
    public let validDeliveryModes: [TCValidDeliveryMode]?
}

// MARK: - TCValidDeliveryMode
public struct TCValidDeliveryMode: Codable {
    public let deliveryDate, fulfilmentType, inventory: String?
    public let isCOD: Bool?
    public let serviceableSlaves: [TCServiceableSlave]?
    public let type: String?
}

// MARK: - TCServiceableSlave
public struct TCServiceableSlave: Codable {
    public let codEligible, logisticsID, priority, slaveID: String?
    public let transactionType: String?

    enum CodingKeys: String, CodingKey {
        case codEligible, logisticsID, priority
        case slaveID = "slaveId"
        case transactionType
    }

}


