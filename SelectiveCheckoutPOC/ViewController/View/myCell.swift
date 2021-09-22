//
//  CheckoutCell.swift
//  SelectiveCheckoutPOC
//
//  Created by Sangat Baral on 21/09/21.
//

import UIKit

class myCell: UITableViewCell {

    var item: CartItem? {
        didSet {
            titleLabel?.text = item?.title
            priceLabel?.text = "Rs: \(item?.price ?? 0)"
            qtyLabel?.text = "Qty: \(item?.qty ?? "0")"
            self.downloadImage(imageurl: "https:\(item?.image ?? "")") { imageDownloaded in
                self.productImage?.image = imageDownloaded
            }

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    @IBOutlet weak var titleLabel: UILabel?
    
    @IBOutlet weak var priceLabel: UILabel?
    @IBOutlet weak var qtyLabel: UILabel?
    @IBOutlet weak var checkBox: UIImageView!
    @IBOutlet weak var productImage: UIImageView?
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkBox.image = selected ? UIImage(named: "whatsAppSelected") : UIImage(named: "whatsAppUnSelected")
        //accessoryType = selected ? .checkmark : .none
    }
    func downloadImage(imageurl : String, onCompletion handler: ((UIImage?) -> ())? = nil) {
        if let url = URL(string: imageurl) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    return
                }
                let image = UIImage(data: data ?? Data())
                DispatchQueue.main.async {
                    handler?(image)
                }
            }
            task.resume()
        }
    }
}
