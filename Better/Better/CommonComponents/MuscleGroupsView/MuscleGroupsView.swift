//
//  MuscleGroupsView.swift
//  Better
//
//  Created by John Jakobsen on 4/16/24.
//

import Foundation
import UIKit

class MuscleGroupsView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {

    let _muscleGroups: [MuscleGroup]
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
    
    init(muscleGroups: [MuscleGroup]) {
        self._muscleGroups = muscleGroups
        
        super.init(frame: CGRect(), collectionViewLayout: LeftAlignedFlowLayout())
        self.delegate = self
        self.dataSource = self
        self.register(MuscleGroupsViewCell.self, forCellWithReuseIdentifier: "MuscleGroupsViewCell")
        self.isScrollEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self._muscleGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MuscleGroupsViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MuscleGroupsViewCell", for: indexPath) as? MuscleGroupsViewCell ?? MuscleGroupsViewCell()
        
        cell.setCellInfo(title: self._muscleGroups[indexPath.row].name)
        
        return cell
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    

}
