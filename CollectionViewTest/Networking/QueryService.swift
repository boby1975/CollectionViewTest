//
//  QueryService.swift
//  CollectionViewTest
//
//  Created by iMAC on 2/14/19.
//  Copyright © 2019 BM-IT. All rights reserved.
//

import Foundation

// Runs query data task and stores results in array of Songs
class QueryService {
    
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([Song]?, String) -> ()
    

    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var songs: [Song] = []
    var errorMessage = ""
    
    
    func getSongSearchResults(searchTerm: String, completion: @escaping QueryResult) {

        dataTask?.cancel()

        if var urlComponents = URLComponents(string: "https://itunes.apple.com/search") {
            urlComponents.query = "term=\(searchTerm)&limit=10"

            guard let url = urlComponents.url else { return }

            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }

                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    self.updateSongSearchResults(data)

                    DispatchQueue.main.async {
                        completion(self.songs, self.errorMessage)
                    }
                }
            }

            dataTask?.resume()
        }
    }
    
    fileprivate func updateSongSearchResults(_ data: Data) {
        var response: JSONDictionary?
        songs.removeAll()
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let array = response!["results"] as? [Any] else {
            errorMessage += "Response does not contain results key\n"
            return
        }
        var index = 0
        for songDictionary in array {
            if let songDictionary = songDictionary as? JSONDictionary,
                let collectionName = songDictionary["collectionName"] as? String,
                let primaryGenreName = songDictionary["primaryGenreName"] as? String,
                let trackName = songDictionary["trackName"] as? String,
                let artistName = songDictionary["artistName"] as? String {
                songs.append(Song(trackName: trackName, artistName: artistName, collectionName: collectionName, primaryGendreName: primaryGenreName))
                index += 1
            } else {
                errorMessage += "Problem parsing songDictionary\n"
            }
        }
        
        print("search index=\(index)")
    }
    
}
