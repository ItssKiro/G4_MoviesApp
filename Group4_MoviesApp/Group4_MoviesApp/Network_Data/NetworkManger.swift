//
//  NetworkManger.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/11/22.
//

import Foundation
import Alamofire

final class networkManger<T: Codable>{
    static func fetch(from urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void){
        AF.request(urlString).responseDecodable(of: T.self){
            (resp) in
            if resp.error != nil{
                completion(.failure(.invalidResponse))
                print(resp.error!)
                return
            }
            
            if let payR = resp.value{
                completion(.success(payR))
                return
            }
            
            completion(.failure(.nilResponse))
            
        }
    }
}
	
enum NetworkError: Error{
    case invalidResponse
    case nilResponse
}
