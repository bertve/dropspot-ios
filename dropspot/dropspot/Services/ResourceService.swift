//
//  ResourceController.swift
//  spotWebTest
//
//  Created by Bert Van eeckhoutte on 26/12/2020.
//

import Foundation

class ResourceService {
    
        
    func sendRequest<Request : ApiRequest>(_ request: Request, completion: @escaping (Result<Request.Response,Error>) -> Void ){
        if let urlRequest = request.urlReq{
            
            Session.defaultSession.dataTask(with: urlRequest){
                (data, response, error) in
                
                //TODO: handle 401 unauth status
                print("HTTP RESPONSE:")
                print(response ?? "")

                if let data = data {
                    do  {
                        let decodedRes = try request.decodeResponse(data: data)
                        completion(.success(decodedRes))
                    } catch {
                        completion(.failure(error))
                    }
                } else if let error = error {
                    completion(.failure(error))
                }
            }.resume()
        } else {
            completion(.failure(ResponseError.invalidURL))
        }
    }
    
}
