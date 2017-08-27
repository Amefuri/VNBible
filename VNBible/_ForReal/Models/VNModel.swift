//
//  VN.swift
//  VNBible
//
//  Created by peerapat atawatana on 1/23/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import Foundation
import IGListKit
import ObjectMapper

/*
id          integer	no	Visual novel ID
title       basic	string	no	Main title
original	basic	string	yes	Original/official title.
released	basic	date (string)	yes	Date of the first release.
languages	basic	array of strings	no	Can be an empty array when nothing has been released yet.
orig_lang	basic	array of strings	no	Language(s) of the first release. Can be an empty array.
platforms	basic	array of strings	no	Can be an empty array when unknown or nothing has been released yet.
aliases     details	string	yes	Aliases, separated by newlines.
length      details	integer	yes	Length of the game, 1-5
description	details	string	yes	Description of the VN. Can include formatting codes as described in d9.3.
links       details	object	no	Contains the following members:
                    "wikipedia", string, name of the related article on the English Wikipedia.
                    "encubed", string, the URL-encoded tag used on encubed.
                    "renai", string, the name part of the url on renai.us.
                    All members can be null when no links are available or known to us.
image       details	string	yes	HTTP link to the VN image.
image_nsfw	details	boolean	no	Whether the VN image is flagged as NSFW or not.
anime       anime	array of objects	no	(Possibly empty) list of anime related to the VN, each object has the following                             members:
                    "id",       integer, AniDB ID
                    "ann_id",   integer, AnimeNewsNetwork ID
                    "nfo_id",   string, AnimeNfo ID
                    "title_romaji", string
                    "title_kanji", string
                    "year", integer, year in which the anime was aired
                    "type", string
                    All members except the "id" can be null. Note that this data is courtesy of AniDB, and may not reflect the latest state of their information due to caching.
                    relations	relations	array of objects	no	(Possibly empty) list of related visual novels, each object has the following members:
                    "id", integer
                    "relation", string, relation to the VN
                    "title", string, (romaji) title
                    "original", string, original/official title, can be null
                    "official", boolean.
tags        tags	array of arrays	no	(Possibly empty) list of tags linked to this VN. Each tag is represented as an array with three elements:
                    tag id (integer),
                    score (number between 0 and 3),
                    spoiler level (integer, 0=none, 1=minor, 2=major)
                    Only tags with a positive score are included. Note that this list may be relatively large - more than 50 tags for a VN is quite possible.
                    General information for each tag is available in the tags dump. Keep in mind that it is possible that a tag has only recently been added and is not available in the dump yet, though this doesn't happen often.
popularity	stats	number	no	Between 0 (unpopular) and 100 (most popular).
rating      stats	number	no	Bayesian rating, between 1 and 10.
votecount	stats	integer	no	Number of votes.
screens     screens	array of objects	no	(Possibly empty) list of screenshots, each object has the following members:
                    "image", string, URL of the full-size screenshot
                    "rid", integer, release ID
                    "nsfw", boolean
                    "height", integer, height of the full-size screenshot
                    "width", integer, width of the full-size screenshot
*/

public class VNModel: Mappable{
    var id: Int = -1
    var title: String?
    var image: String?
    
    /*init(id: Int, title: String?, image: String?) {
        self.id = id
        self.title = title
        self.image = image
    }*/
    
    required public init?(map: Map) {
        
    }
    
    // Mappable
    public func mapping(map: Map) {
        id      <- map["id"]
        title   <- map["title"]
        image   <- map["image"]
    }
}

extension VNModel: IGListDiffable {
    
    public func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    public func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        if let vnModel = object as? User {
            return id == vnModel.id
        }
        return false
    }
}

