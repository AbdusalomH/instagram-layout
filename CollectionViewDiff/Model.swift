//
//  Model.swift
//  CollectionViewDiff
//
//  Created by Mac on 8/25/23.
//

import Foundation


// MARK: - PhotoModel





// MARK: - Welcome
struct PhotoModel: Codable {
    let totalResults: Int?
    let page: Int?
    let perPage: Int?
    let photos: [Photo]

}

// MARK: - Photo
struct Photo: Codable, Hashable {
    let id, width, height: Int?
    let url: String?
    let photographer: String?
    let photographerURL: String?
    let photographerID: Int?
    let avgColor: String?
    let src: Src
    let liked: Bool?
    let alt: String?

}

// MARK: - Src
struct Src: Codable, Hashable {
    let original, large2X, large, medium: String?
    let small, portrait, landscape, tiny: String?

}




