//
//  JSONDecoderViewController.swift
//  CodableAndJSONDecodingChallenge
//
//  Created by John Williams III on 7/18/19.
//  Copyright © 2019 John Williams III. All rights reserved.
//

import UIKit
import Foundation

struct ProductCollection: Codable {
    var status: String
    //var photosPath: String
    var products: [Product]
    
    enum CodingKeys: String, CodingKey {
        case status
        //case photosPath = "photos_path"
        case products
    }
}

struct Product: Codable {
    var id: Int
    var category: String
    var title: String
    var price: Double
    var stockedQuantity: Int
}

class JSONDecoderViewController: UIViewController {

    @IBOutlet weak var infoTextView: UITextView!
    
    let jsonFileName = "inventory"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let productCollection = JSONDecoderViewController.load(jsonFileName: jsonFileName) {
            var displayInfo = ""
            displayInfo += "Status: \(productCollection.status)\n\n\n"

            for product in productCollection.products {
                displayInfo += "Inventory:\n"
                displayInfo += "ID: \(product.id)\n"
                displayInfo += "Category: \(product.category)\n"
                displayInfo += "Title: \(product.title)\n"
                displayInfo += "Price: \(product.price)\n"
                displayInfo += "Quantity: \(product.stockedQuantity)\n\n"
            }
            infoTextView.text = displayInfo
        } else {
            infoTextView.text = "Error."
        }
        // Do any additional setup after loading the view.
    }
    


    class func load(jsonFileName: String) -> ProductCollection? {
        var productCollection: ProductCollection?
        let jsonDecoder = JSONDecoder()
        
        if let jsonFileUrl = Bundle.main.url(forResource: jsonFileName, withExtension: ".json"),
            let jsonData = try? Data(contentsOf: jsonFileUrl) {
            productCollection = try? jsonDecoder.decode(ProductCollection.self, from: jsonData)
        }
        
        return productCollection
    }
    

}
