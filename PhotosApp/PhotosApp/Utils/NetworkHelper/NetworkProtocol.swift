//
//  NetworkProtocol.swift
//  PhotosApp
//
//  Created by Rajeswaran on 16/02/23.
//

import Foundation

protocol NetworkProtocol {
    func performTask<T: Decodable>(urlString: String, completion: @escaping (Result<T,Error>) -> Void)
}


class NetworkHelper: NetworkProtocol {
    func performTask<T>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        
    }
  
    
}
