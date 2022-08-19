//
//  GuestSessionResponse.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 19/8/22.
//

import Foundation

struct GuestSessionResponse: Codable {
    let success: Bool
    let guestSessionId: String
    let expiresAt: String
}
