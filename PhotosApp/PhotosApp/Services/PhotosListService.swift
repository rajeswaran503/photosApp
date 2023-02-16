//
//  PhotosListService.swift
//  PhotosApp
//
//  Created by Rajeswaran Thangaperumal on 16/02/23.
//

import Foundation

protocol PhotosListServiceProtocol {
    func getPhotos(completion: @escaping ( _ results: [Photo]?, _ error: String?) -> ())
}

class PhotosListService: PhotosListServiceProtocol {
    func getPhotos(completion: @escaping ([Photo]?, String?) -> ()) {
    
        NetworkHelper().performTask(url: ServiceUrl.baseUrl) { (success, responseData) in
            if success {
                do {
                    let model = try JSONDecoder().decode([Photo].self, from: responseData!)
                   completion(model,nil)
                } catch {
                    completion(nil, "Error: Trying to parse Employees to model")
                }
            } else {
                completion(nil, responseData?.description)
            }
        }
    }
}
