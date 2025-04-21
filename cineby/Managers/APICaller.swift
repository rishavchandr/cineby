//
//  APICaller.swift
//  cineby
//
//  Created by Rishav chandra on 15/04/25.
//

import Foundation


struct Constants {
    static let apiKey = "697d439ac993538da4e3e60b54e762cd"
    static let baseUrl = "https://api.themoviedb.org"
    static let Youtube_apiKey = "AIzaSyDdk0U_2EWiXY3rK2G-rQPJ3WX9fNDgJFE"
}

class APICaller {
    static let shared = APICaller()
    
    enum APIError: Error {
        case failedToFetchData
    }
    
    func getTrendingMovies(completion : @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/movie/day?api_key=\(Constants.apiKey)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data , _ , error in
            guard let data = data , error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(APIError.failedToFetchData))
            }
        }
        task.resume()
    }
    
    func getTrendingTvs(completion : @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/tv/day?api_key=\(Constants.apiKey)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data , _ , error in
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(APIError.failedToFetchData))
            }
        }
        task.resume()
    }
    
    func getUpComingMovies(completion : @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/upcoming?api_key=\(Constants.apiKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: url) { data , _ , error in
            guard let data = data , error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self , from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(APIError.failedToFetchData))            }
        }
        task.resume()
    }
    
    func getPopularMovies(completion : @escaping (Result<[Title] , Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/popular?api_key=\(Constants.apiKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: url) { data , _ , error in
            guard let data = data , error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self , from: data)
                completion(.success(results.results))
                
            }catch {
                completion(.failure(APIError.failedToFetchData))
            }
        }
        task.resume()
    }
    
    func getTopRatedMovies(completion : @escaping (Result<[Title] , Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/top_rated?api_key=\(Constants.apiKey)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: url) { data , _ , error in
            guard let data = data , error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self , from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(APIError.failedToFetchData))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title],Error>)-> Void){
        guard let url = URL(string:
        "\(Constants.baseUrl)/3/discover/movie?api_key=\(Constants.apiKey)&language=en-US&sort_by=popularity .desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate" ) else {return }
        
        let task = URLSession.shared.dataTask(with: url) { data , _ , error in
            guard let data = data , error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self , from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(APIError.failedToFetchData))
            }
        }
        task.resume()
    }
    
    func search(query: String , completion: @escaping(Result<[Title],Error>)->Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseUrl)/3/search/movie?api_key=\(Constants.apiKey)&query=\(query).") else {return}
        let task = URLSession.shared.dataTask(with: url) { data , _ , error in
            guard let data = data , error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self , from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(APIError.failedToFetchData))
            }
        }
        task.resume()
    }
    
    func searchMovie(query: String , completion: @escaping(Result<VideoElement,Error>)->Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "https://www.googleapis.com/youtube/v3/search?q=\(query)&key=\(Constants.Youtube_apiKey)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data , _ , error in
            guard let data = data , error == nil else {return}
            do {
                let results = try JSONDecoder().decode(YoutubeVideoResponse.self, from: data)
                completion(.success(results.items[0]))
            }catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
