//
//  NetworkManager.swift
//  CoreDataProject
//
//  Created by Field Employee on 11/6/20.
//

import Foundation

final class NetworkManager {
    static var shared = NetworkManager()
    let session: URLSession
    private init (session: URLSession = URLSession.shared)
    {
        self.session = session
    }
}

extension NetworkManager {
    func getSongList(url1:String, completion: @escaping ([songInfo]) -> ()) {
        guard let url = URL(string: "http://rss.itunes.apple.com/api/v1/us/itunes-music/top-songs/all/100/explicit.json") else {return}
        session.dataTask(with: url){ (data, resonse, error) in
            do{
                let x = try JSONDecoder().decode(songModel.self, from: data!)
                completion(x.feed.results)
                
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
        return
    }
}
