//
//  Session.swift
//  Task1
//
//  Created by macbook on 15.12.2020.
//

import Foundation
import Unrealm


final class Session {
    var token: String?
    var userId: Int?
    let session =  URLSession(configuration: URLSessionConfiguration.default)
    
    static let shared = Session()
    
    private init() {}
    
    func requestToAPI<T: Decodable>(url: URLRequest, typeReceiver: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let task = self.session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            do {
//                                let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves)
//                                                       print(json)
                let results = try JSONDecoder().decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(results))
                }
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }
        }
        task.resume()
    }
    
//    func getDateFromServer<T>(typeDate: T.Type, request: URLRequest) where T:Decodable, T:Realmable {
//        Session.shared.requestToAPI(url: request, typeReceiver: Root<T>.self) { results in
//            var data: [T] = [T]()
//            switch results {
//            case .success(let response):
//                response.fotos.forEach {
//                    data.append($0)
//                }
//
//                Keeper.saveData(data)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    func updateFromServer() {
        let opq = OperationQueue()
        let requestFotoFish = RequestApi.requestPhotoFish()
        
        let opFriend = GetDataOperation(request: requestFotoFish, typeDate: Photos.self)
        opFriend.completionBlock = {
            Keeper.saveData(opFriend.data)
        }
        
        opq.addOperation(opFriend)
    }
}

final class RequestApi {
    static let scheme: String = "https"
    static let hostAPI: String = "api.pexels.com"
    
    static func requestPhotoFish() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = hostAPI
        urlComponents.path = "/v1/search"
        urlComponents.queryItems = [
            URLQueryItem(name: "query", value: "fish")
        ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.allHTTPHeaderFields = ["Authorization" : "563492ad6f917000010000019b00ea1a02264ddda574bfa6b1d38be8"]
        
        return request
    }
}

