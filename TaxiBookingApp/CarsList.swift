//
//  CarsList.swift
//  TaxiBookingApp
//
//  Created by Vignesh on 01/04/19.
//  Copyright © 2019 Vignesh. All rights reserved.
//

import UIKit

class CarsList: UICollectionView, UICollectionViewDataSource,UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCell", for: indexPath) as? CarCell
        return cell!
    }
    

   

}
