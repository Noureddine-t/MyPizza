//
//  CommandeCellView.swift
//  MyPizza
//
//  Created by Nour Eddine Taleb on 16/01/2025.
//

import SwiftUI

struct OrdersCellView: View {
    var orders = OrdersData(recipe: "", dough: "", orderDate: "")
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(orders.recipe)
                Text(orders.dough)
            }
            Spacer()
            Text(orders.orderDate)
        }
        .padding()
    }
}

#Preview {
    OrdersCellView(orders: orders)
}

