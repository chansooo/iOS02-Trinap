//
//  ReviewDTO.swift
//  Trinap
//
//  Created by Doyun Park on 2022/11/16.
//  Copyright © 2022 Trinap. All rights reserved.
//

import Foundation

struct ReviewDTO: Codable {
    
    // MARK: - Properties
    let creatorUserId, photographerUserId, reviewId, contents, status: String
    let rating: Int
    
    func toModel() -> Review {
        return Review(
            creatorUserId: creatorUserId,
            photographerUserId: photographerUserId,
            reviewId: reviewId,
            contents: contents,
            status: status,
            rating: rating
        )
    }
}
 
