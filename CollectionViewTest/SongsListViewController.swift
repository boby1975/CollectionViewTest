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
    let queryService = QueryService()
    let searchTerm = "jack+white"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songsListCollectionView.delegate = self
        songsListCollectionView.dataSource = self
        songsListCollectionView.showsVerticalScrollIndicator = false
        
        getSongs()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let flowLayout = self.songsListCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: self.songsListCollectionView.bounds.width, height: 60)
        }
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
            
            case "fromSongListToSongDetailSegue":
                print ("fromSongListToSongDetailSegue")
            
                if let navigationController = segue.destination as? UINavigationController,
                    let createViewController = navigationController.viewControllers.first as? SongDetailViewController,
                    let selectedItem = songsListCollectionView.indexPathsForSelectedItems?.first {
                    createViewController.song = songsList[selectedItem.item]
                }
            
            default:
                print ("segue ID: " + segue.identifier!)
            break
        }
    }
    
    //MARK: Private Query Data
    fileprivate func getSongs(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        queryService.getSongSearchResults(searchTerm: searchTerm) { results, errorMessage in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let results = results {
                self.songsList = results
                self.songsListCollectionView.reloadData()
                self.songsListCollectionView.setContentOffset(CGPoint.zero, animated: false)
                
                if self.songsList.count > 0 {
                    print ("result find songs ok")
                } else {
                    print ("find songs no records")
                }
            }
            if !errorMessage.isEmpty { print("find songs error: " + errorMessage) }
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
        let selectedCell = indexPath.row
        print("selected cell: \(selectedCell)")
        performSegue(withIdentifier: "fromSongListToSongDetailSegue", sender: self)
    }
}
