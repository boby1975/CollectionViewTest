//
//  SongDetailViewController.swift
//  CollectionViewTest
//
//  Created by iMAC on 2/14/19.
//  Copyright © 2019 BM-IT. All rights reserved.
//

import UIKit

class SongDetailViewController: UIViewController {

    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var primaryGendreName: UILabel!
    
    var song: Song!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        artistName.text = song.artistName
        trackName.text = song.trackName
        collectionName.text = song.collectionName
        primaryGendreName.text = song.primaryGendreName

    }
    

    //MARK: Navigation
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
