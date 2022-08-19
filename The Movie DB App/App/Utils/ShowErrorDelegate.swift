//
//  ShowErrorDelegate.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 18/8/22.
//

import Foundation

protocol ShowErrorDelegate: AnyObject {
    func showError(title: String, message: String)
}
