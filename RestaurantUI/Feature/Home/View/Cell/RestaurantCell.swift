//
//  RestaurantCell.swift
//  RestaurantUI
//
//  Created by David Gomez on 14/11/2022.
//

import SwiftUI

struct RestaurantCell: View {
    @State var item: Restaurant
    var imageUseCase: ImageUseCaseProtocol = ImageUseCase()
    @State var image: UIImage = UIImage()
    @State var isFavorite: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(20)
            
            HStack(alignment: .firstTextBaseline) {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.title)
                    
                    Text(item.address.street)
                        .font(.subheadline)
                    Text(String(item.aggregateRatings.thefork.ratingValue))
                        .font(.subheadline)
                }
                Spacer()
                Button { } label: {
                    Image(isFavorite ? "FILLED_HEART_IMAGE_NAME".localized : "EMPTY_HEART_IMAGE_NAME".localized)
                }
                .onTapGesture {
                    setFavourite()
                }
            }
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.gray)
                .padding(.top, 10)
        }
        .task {
                getFavorite()
                do {
                    let imageData = try await imageUseCase.loadImage(url: item.mainPhoto?.photo_612x344 ?? "")
                    let finalImage: UIImage = UIImage(data: imageData) ?? UIImage()
                    self.image = finalImage
                }
                catch {
                    self.image = UIImage()
                }

        }
    }
    
    func getFavorite() {
        let uuid =  item.uuid
        isFavorite = UserDefaults.standard.object(forKey: uuid) as? Bool ?? false
    }
    
    func setFavourite() {
        let uuid =  item.uuid
        let currentValue = UserDefaults.standard.object(forKey: uuid) as? Bool ?? false
        UserDefaults.standard.set(currentValue ? false : true, forKey: uuid)
        
        getFavorite()
    }
}

struct RestaurantCell_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantCell(item: Restaurant(name: "Test ABC",
                                        uuid: "",
                                        address: Restaurant.Address(street: "Fallieres 661", postalCode: "1828", locality: "Buenos Aires", country: "Argentina"),
                                        aggregateRatings: Restaurant.AgregateRating(thefork: Restaurant.RatingDetail(ratingValue: 9, reviewCount: 10))))
    }
}
