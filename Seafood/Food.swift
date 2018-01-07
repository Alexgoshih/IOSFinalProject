//
//  Food.swift
//  Seafood
//
//  Created by Yotta on 2018/1/7.
//  Copyright © 2018年 Yotta. All rights reserved.
//

import Foundation
import UIKit

struct Food: Codable {
    var name: String
    var date: String
    var innerBeauty: Bool
    var imageName: String?
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static func saveToFile(foods: [Food]) {
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(foods) {
            let url = Food.documentsDirectory.appendingPathComponent("food")
            try? data.write(to: url)
        }
    }
    
    static func readFoodsFromFile() -> [Food]? {
        let propertyDecoder = PropertyListDecoder()
        let url = Food.documentsDirectory.appendingPathComponent("food")
        if let data = try? Data(contentsOf: url), let foods = try? propertyDecoder.decode([Food].self, from: data) {
            return foods
        } else {
            return nil
        }
    }
    
    
    var image: UIImage? {
        if let imageName = imageName {
            let url = Food.documentsDirectory.appendingPathComponent(imageName)
            return UIImage(contentsOfFile: url.path)
        } else {
            return  #imageLiteral(resourceName: "head")
        }
    }
}

