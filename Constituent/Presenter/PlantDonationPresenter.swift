//
//  PlantDonationPresenter.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 22/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct PlantDonationData {
    let no_of_plant : String
    let name_of_plant : String
    let created_at : String

}

protocol PlantDonationView: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setPlantDonation(plant: PlantDonationData)
    func setEmpty(errorMessage:String)
}


class PlantDonationPresenter {

        private let plantDonationService: PlantDonationService
        weak private var plantDonationView : PlantDonationView?

        init(plantDonationService:PlantDonationService) {
            self.plantDonationService = plantDonationService
        }
        
        func attachView(view:PlantDonationView) {
            plantDonationView = view
        }
        
        func detachView() {
            plantDonationView = nil
        }
        
      func getPlantDonation(user_id:String) {
            self.plantDonationView?.startLoading()
            plantDonationService.callAPIPlant(
              user_id: user_id, onSuccess: { (plant) in
                    self.plantDonationView?.finishLoading()
                self.plantDonationView?.setPlantDonation(plant: PlantDonationData(no_of_plant: "\(plant.no_of_plant ?? "")", name_of_plant: "\(plant.name_of_plant ?? "")", created_at: "\(plant.created_at ?? "")"))
                },
                onFailure: { (errorMessage) in
                    self.plantDonationView?.finishLoading()
                    self.plantDonationView?.setEmpty(errorMessage: errorMessage)

                }
            )
        }
}
