//
//  DisplayNewReleaseContainer.swift
//  VNBible
//
//  Created by peerapat atawatana on 2/9/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import Foundation
import IGListKit

class DisplayNewReleaseContainer {
    let identifier: String
    let displayNewReleases: [DisplayNewRelease]
    
    init(displayNewReleases: [DisplayNewRelease]) {
        self.identifier = "displayNewReleaseContainer"
        self.displayNewReleases = displayNewReleases
    }
}

extension DisplayNewReleaseContainer: IGListDiffable {
    
    // @see: https://github.com/rnystrom/SimpleWeather/blob/master/SimpleWeather/Classes/Models/DailyForecastSection%2BIGListDiffable.swift
    func diffIdentifier() -> NSObjectProtocol {
        return "displayNewReleaseContainer" as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? DisplayNewReleaseContainer else { return false }
        return identifier == object.identifier
    }
}
