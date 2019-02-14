//
//  ViewController.swift
//  CollectionViewTest
//
//  Created by iMAC on 2/14/19.
//  Copyright © 2019 BM-IT. All rights reserved.
//

import UIKit

class SongsListViewController: UIViewController {

    @IBOutlet weak var songsListCollectionView: UICollectionView!
    var songsList: [Song] = []
    var selectedCell: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songsListCollectionView.delegate = self
        songsListCollectionView.dataSource = self
        songsListCollectionView.showsVerticalScrollIndicator = false
        
        //for test
        songsList.removeAll()
        songsList.append(Song(trackName: "track 1", artistName: "artist 1", collectionName: "collection 1", primaryGendreName: "Gendre 1"))
        songsList.append(Song(trackName: "track 2", artistName: "artist 2", collectionName: "collection 2", primaryGendreName: "Gendre 2"))
        songsList.append(Song(trackName: "track 3", artistName: "artist 3", collectionName: "collection 3", primaryGendreName: "Gendre 3"))
        songsList.append(Song(trackName: "track 4", artistName: "artist 4", collectionName: "collection 4", primaryGendreName: "Gendre 4"))
        songsList.append(Song(trackName: "track 5", artistName: "artist 5", collectionName: "collection 5", primaryGendreName: "Gendre 5"))
        
    }

    
    
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
            
            case "fromSongListToSongDetailSegue":
                print ("fromSongListToSongDetailSegue")
            
                if let navigationController = segue.destination as? UINavigationController,
                    let createViewController = navigationController.viewControllers.first as? SongDetailViewController {
                    createViewController.song = songsList[selectedCell]
                }
            
            default:
                print ("segue ID: " + segue.identifier!)
            break
        }
    }
}



extension SongsListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SongCell", for: indexPath) as! SongCell
        cell.artistName.text = songsList[indexPath.row].artistName
        cell.trackName.text = songsList[indexPath.row].trackName
        return cell
    }
}

extension SongsListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = indexPath.row
        print("selected cell: \(String(describing: selectedCell))")
        performSegue(withIdentifier: "fromSongListToSongDetailSegue", sender: self)
    }
}
