//
//  FlickrSearchService.swift
//  SwiftFlickrSearchDemo
//
//  Created by kiras on 2020/3/6.
//  Copyright © 2020 ameyo. All rights reserved.
//

import Foundation

class FlickrSearchService {
    
    static let shared = FlickrSearchService()
    
    struct Keys {
        static let flickrKey = "a4f28588b57387edc18282228da39744"
    }
    
    func fetchPhotosForSearchText(searchText: String, quantity: Int, completion: @escaping([Photo]?, Error?) -> ()) {
        
        let urlString: String = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(Keys.flickrKey)&format=json&nojsoncallback=1&safe_search=1&per_page=\(quantity)&text=\(searchText)&page=1"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let data = data else { return }
            
            if let err = err {
                print("Error fetching photos: \(err)")
                completion(nil, err)
                return
            }
            
            do {
                
                let resultsDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                guard let photosContainer = resultsDictionary!["photos"] as? Dictionary<String, Any> else { return }
                
                guard let photosArray = photosContainer["photo"] as? [Dictionary<String, Any>] else { return }
                
                let flickrPhotos: [Photo] = photosArray.map {
                    photoDictionary in
                    
                    let photoId = photoDictionary["id"] as? String ?? ""
                    let owner = photoDictionary["owner"] as? String ?? ""
                    let secret = photoDictionary["secret"] as? String ?? ""
                    let server = photoDictionary["server"] as? String ?? ""
                    let farm = photoDictionary["farm"] as? Int ?? 0
                    let title = photoDictionary["title"] as? String ?? ""
                    let ispublic = photoDictionary["ispublic"] as? Int ?? 0
                    let isfriend = photoDictionary["isfriend"] as? Int ?? 0
                    let isfamily = photoDictionary["isfamily"] as? Int ?? 0
                    
                    let flickrPhoto = Photo(id: photoId, owner: owner, secret: secret, server: server, farm: farm, title: title, ispublic: ispublic, isfriend: isfriend, isfamily: isfamily)
                    
                    return flickrPhoto
                }
                DispatchQueue.main.async {
                    completion(flickrPhotos, nil)
                }
            } catch let jsonError {
                completion(jsonError as? [Photo], nil)
                print("Failed to decode json:", jsonError)
            }
        }
        .resume()
    }
    
}
