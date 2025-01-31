//
//  CommandeCellView.swift
//  MyPizza
//
//  Created by Nour Eddine Taleb on 16/01/2025.
//

import SwiftUI

struct OrdersCellView: View {
    var orders : OrdersData
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(orders.recipe)
                Text(orders.dough)
            }
            Spacer()
            VStack(alignment: .trailing){
                let dateComponents = orders.orderDate.split(separator:" ")
                Text(dateComponents[0])
                Text(dateComponents[1])
            }
        }
        .padding()
    }
}
