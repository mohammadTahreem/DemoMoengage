//
//  AllItemsView.swift
//  DemoMoengage
//
//  Created by Tahreem on 13/10/21.
//

import SwiftUI

struct AllItemsView: View {
    
    var dataList: [SampleData] = [
        SampleData(productName: "Watch", productDescription: "Best Watch", productPrice: 10.01),
        SampleData(productName: "Jacket", productDescription: "Best Jacket", productPrice: 20.20),
        SampleData(productName: "Pant", productDescription: "Best pants in the world with excuisite shape and size", productPrice: 20.99),
        SampleData(productName: "Gloves", productDescription: "Very good gloves", productPrice: 10.07)
    ]
    
    var body: some View {
        VStack{
            List(dataList, id: \.self){ product in
                NavigationLink(destination: ProductDetails(product: product)){
                    ProductStructure(product: product)
                }
            }
        }
    }
}

struct AllItemsView_Previews: PreviewProvider {
    static var previews: some View {
        AllItemsView()
    }
}
