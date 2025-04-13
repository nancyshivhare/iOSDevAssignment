//
//  itemModel.swift
//  Assignment_iOS
//
//  Created by apple on 12/04/25.
//


import Foundation

// Modify the model to handle different JSON structures
struct ItemModel: Codable {
    let id: String
    let name: String
    let data: ItemData?
}

struct ItemData: Codable {
    var color: String?
    var capacity: String?
    var capacityGB: Int? // Handle the case where capacity is given as "capacity GB"
    var price: Double?
    var generation: String?
    var year: Int?
    var cpuModel: String?
    var hardDiskSize: String?
    var strapColour: String?
    var caseSize: String?
    var screenSize: Double?
    
    enum CodingKeys: String, CodingKey {
        case color
        case capacity
        case capacityGB = "capacity GB"
        case price
        case generation
        case year
        case cpuModel = "CPU model"
        case hardDiskSize = "Hard disk size"
        case strapColour = "Strap Colour"
        case caseSize = "Case Size"
        case screenSize = "Screen size"
    }
}
