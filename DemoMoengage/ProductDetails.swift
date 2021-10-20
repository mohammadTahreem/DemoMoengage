//
//  ProductDetails.swift
//  DemoMoengage
//
//  Created by Tahreem on 13/10/21.
//

import SwiftUI
import MoEngage

struct ProductDetails: View {
    var product: SampleData
    @State var addToCart = true
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Spacer()
                Text(product.productName)
                    .font(.largeTitle)
                Text(product.productDescription)
                Text("\(product.productPrice)")
                    .font(.caption)
                Spacer()
                
            }.padding()
            Button(addToCart ? "Add to cart" : "Buy"){
                addToCart = false
                createEvent(productName: product.productName)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(radius: 10)
        }
    }
    
    func createEvent(productName: String){
        let eventAttrDict = NSMutableDictionary()
        eventAttrDict["ProductName"] = productName
        eventAttrDict["BrandName"] = "Apple"
        eventAttrDict["Items In Stock"] = 109

        let eventProperties = MOProperties.init(attributes: eventAttrDict)

        eventProperties.addAttribute(product.productPrice, withName: "price")
        eventProperties.addAttribute("Dollars", withName: "currency")
        eventProperties.addAttribute(true, withName: "in_stock")
        if #available(iOS 15, *) {
            eventProperties.addDateEpochAttribute(Date.now.timeIntervalSince1970, withName: "Time added to cart")
        } else {
            eventProperties.addDateEpochAttribute(1493000, withName: "Time added to cart")
        }
        eventProperties.addDateISOStringAttribute("2020-02-22T12:37:56Z", withName: "Time of checkout")
        eventProperties.addDateAttribute(Date(), withName: "Time of purchase")

        eventProperties.addLocationAttribute(MOGeoLocation.init(latitude: 12.23, andLongitude: 9.23), withName: "Pickup Location")
        
        if !addToCart {
            MoEngage.sharedInstance().trackEvent("Successful Purchase", with: eventProperties)
        }else{
            MoEngage.sharedInstance().trackEvent("Added to cart", with: eventProperties)
        }
    }
}

struct ProductDetails_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetails(product: SampleData(productName: "Pant", productDescription: "Awesome Product", productPrice: 1))
    }
}
