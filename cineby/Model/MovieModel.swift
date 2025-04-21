//
//  MovieModel.swift
//  cineby
//
//  Created by Rishav chandra on 15/04/25.
//

import Foundation


struct TrendingTitleResponse: Codable {
    let results : [Title]
}

struct Title : Codable {
    let id: Int
    let media_type: String?
    let original_language: String?
    let original_name: String?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let vote_count: Int?
    let backdrop_path: String?
    let first_air_date: String?
    let origin_country: [String]?
    let vote_average: Double?
}



/*
 adult = 0;
 "backdrop_path" = "/vIioWssbxRtEkIzgj8r0pCWYkYM.jpg";
 "first_air_date" = "2022-12-18";
 "genre_ids" =             (
     18,
     37
 );
 id = 157744;
 "media_type" = tv;
 name = 1923;
 "origin_country" =             (
     US
 );
 "original_language" = en;
 "original_name" = 1923;
 overview = "Follow a new generation of the Dutton family during the early twentieth century when pandemics, historic drought, the end of Prohibition and the Great Depression all plague the mountain west, and the Duttons who call it home.";
 popularity = "77.922";
 "poster_path" = "/vNJWr0xh7W5IDzFTnVzWhw6KoJr.jpg";
 "vote_average" = "8.199";
 "vote_count" = 525;
 */
