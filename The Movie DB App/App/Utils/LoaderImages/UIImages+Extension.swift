//
//  UIImages+Extension.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 2/9/22.
//

import UIKit

extension UIImageView {
  func loadImage(at url: URL) {
    UIImageLoader.loader.load(url, for: self)
  }

  func cancelImageLoad() {
    UIImageLoader.loader.cancel(for: self)
  }
}
