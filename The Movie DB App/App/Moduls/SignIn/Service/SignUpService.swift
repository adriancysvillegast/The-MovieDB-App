//
//  SignUpService.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 19/8/22.
//

import Foundation

protocol SignUpServiceFetching{
    func get(onComplete: @escaping (GuestSessionResponse) -> (), onError: @escaping (String) -> () )
}

class SignUpService: SignUpServiceFetching{

    //MARK: - properties
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"]!
    private let endpointGuestSession = ProcessInfo.processInfo.environment["endPointGuestSession"]!
    private let apiKey = ProcessInfo.processInfo.environment["apiKey"]!
    
    //MARK: - get token
    func get(onComplete: @escaping (GuestSessionResponse) -> (), onError: @escaping (String) -> ()) {
        APIManager.shared.get(url: "\(baseURL)\(endpointGuestSession)api_key=\(apiKey)") { data in
            guard let safeData = data else { return }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let guestSession = try decoder.decode(GuestSessionResponse.self, from: safeData)
                onComplete(guestSession)
            }catch{
                onError(error.localizedDescription)
            }
        } onError: { error in
            guard let e = error else { return }
            onError(e.localizedDescription)
        }

    }
    
}
