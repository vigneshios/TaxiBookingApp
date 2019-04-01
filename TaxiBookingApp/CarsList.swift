//
//  CarsList.swift
//  TaxiBookingApp
//
//  Created by Vignesh on 01/04/19.
//  Copyright © 2019 Vignesh. All rights reserved.
//

import UIKit

class CarsList: UICollectionView, UICollectionViewDataSource,UICollectionViewDelegate {
    
    var cars = ["UberGo", "Premier", "UberSUV"]
    
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCell", for: indexPath) as! CarCell
        cell.carTypeLbl.text = cars[indexPath.row]
        cell.carImage.image = UIImage(named: cars[indexPath.row])
        return cell
    }
    

   

}
