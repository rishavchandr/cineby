//
//  YoutubeVideoResponse.swift
//  cineby
//
//  Created by Rishav chandra on 21/04/25.
//

import Foundation

struct YoutubeVideoResponse : Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IDVideoElement
}

struct IDVideoElement: Codable {
    let kind: String
    let videoId: String
 }
