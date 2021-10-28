//
//  File.swift
//  
//
//  Created by Łukasz Łuczak on 28/10/2021.
//

import Foundation
import Combine

public protocol NetworkManagerProtocol {
    func download(url: URL) -> AnyPublisher<Data, Error>
    func handleCompletion(completion: Subscribers.Completion<Error>)
}

class NetworkManager: NetworkManagerProtocol {
    func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap( {try self.handleURLResponse(output: $0, url: url)} )
            .eraseToAnyPublisher()
    }
}

extension NetworkManager {
    enum NetworkManageError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String {
            switch self {
            case .badURLResponse(url: let url): return "Bad response from URL: \(url)"
            case .unknown: return "Unknown error occured"
            }
        }
    }
    
    private func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data  {
        guard let response  = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkManageError.badURLResponse(url: url)
        }
        
        return output.data
    }
    
    func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
