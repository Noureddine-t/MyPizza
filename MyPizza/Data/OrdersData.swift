//
//  Order.swift
//  MyPizza
//
//  Created by Nour Eddine Taleb on 16/01/2025.
//

import Foundation
struct OrdersData: Codable, Identifiable, Hashable {
    var recipe:String
    var dough: String
    var orderDate: String
}
