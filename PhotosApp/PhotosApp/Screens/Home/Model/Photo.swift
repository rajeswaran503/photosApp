//
//  Photo.swift
//  PhotosApp
//
//  Created by Rajeswaran on 16/02/23.
//

import Foundation

struct Photo: Codable {
    let albumId: Int?
    let id: Int?
    var title: String?
    let url: String?
    let thumbnailUrl: String?
}
