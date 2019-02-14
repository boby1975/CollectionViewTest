//
//  Song.swift
//  CollectionViewTest
//
//  Created by iMAC on 2/14/19.
//  Copyright © 2019 BM-IT. All rights reserved.
//

import Foundation

class Song {
    
    let trackName: String
    let artistName: String
    let collectionName: String
    let primaryGendreName: String
    
    init(trackName: String, artistName: String, collectionName: String, primaryGendreName: String){
        self.trackName = trackName
        self.artistName = artistName
        self.collectionName = collectionName
        self.primaryGendreName = primaryGendreName
    }
}
