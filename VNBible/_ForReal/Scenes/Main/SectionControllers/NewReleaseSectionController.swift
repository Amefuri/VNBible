//
//  NewReleaseSectionController.swift
//  VNBible
//
//  Created by peerapat atawatana on 1/26/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//


import UIKit
import IGListKit
import AFNetworking

final class NewReleaseSectionController: IGListSectionController, IGListSectionType {
    
    var displayNewRelease: DisplayNewRelease?
    
    override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    }
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: 120, height: 166)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(withNibName: "NewReleaseCell", bundle: nil, for: self, at: index) as! NewReleaseCell
        cell.title.text = displayNewRelease?.title
        if let url = URL(string: displayNewRelease?.image ?? "") {
            cell.image.setImageWith(url)
        }
        
        return cell
    }
    
    func didUpdate(to object: Any) {
        displayNewRelease = object as? DisplayNewRelease
    }
    
    func didSelectItem(at index: Int) {}
    
}

// @see: http://stackoverflow.com/a/39612638
/*extension String {
    subscript (r: CountableClosedRange<Int>) -> String {
        get {
            let startIndex =  self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(startIndex, offsetBy: r.upperBound - r.lowerBound)
            return self[startIndex...endIndex]
        }
    }
}*/

