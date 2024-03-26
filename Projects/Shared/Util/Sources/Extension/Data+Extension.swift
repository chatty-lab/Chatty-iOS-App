//
//  Data+Extension.swift
//  SharedUtil
//
//  Created by 윤지호 on 3/19/24.
//

import UIKit

extension Data {
  public func toUIImage() -> UIImage {
    guard let image = UIImage(data: self) else {
      return UIImage()
    }
    return image
  }
}
