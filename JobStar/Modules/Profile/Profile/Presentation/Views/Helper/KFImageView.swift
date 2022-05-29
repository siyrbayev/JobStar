//
//  KFImageView.swift
//  JobStar
//
//  Created by siyrbayev on 20.05.2022.
//

import SwiftUI
//import struct Kingfisher.KFImage
//import struct Kingfisher.AnyModifier
import Kingfisher

@ViewBuilder
func KFImageView(url: String, placeholder: Image) -> KFImage {
    KFImage(URL(string: url))
        .placeholder {
            placeholder
        }
        .resizable()
}
