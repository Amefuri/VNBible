//
//  DisplayNewRelease.swift
//  VNBible
//
//  Created by peerapat atawatana on 1/26/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import IGListKit

public class DisplayNewRelease{
    var id: Int = -1
    var title: String?
    var image: String?
    
    init(id:Int, title:String?, image:String?) {
        self.id = id
        self.title = title
        self.image = image
    }
}

extension DisplayNewRelease: IGListDiffable {
    
    public func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    public func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        if let displayNewRelease = object as? User {
            return id == displayNewRelease.id
        }
        return false
    }
}

