//
//  ProductStructure.swift
//  DemoMoengage
//
//  Created by Tahreem on 13/10/21.
//

import SwiftUI

struct ProductStructure: View {
    var product: SampleData
    var body: some View {
        VStack(alignment: .leading){
            Text(product.productName)
                .font(.title)
            Text(product.productDescription)
                .font(.headline)
            Text("\(round(product.productPrice))")
                .font(.caption)
        }
    }
}

struct ProductStructure_Previews: PreviewProvider {
    static var previews: some View {
        ProductStructure(product: SampleData(productName: "Watch", productDescription: "Finest watches", productPrice: 1))
    }
}
