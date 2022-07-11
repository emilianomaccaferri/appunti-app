//
//  Shake.swift
//  appunti.me
//
//  Created by Emiliano Maccaferri on 10/07/22.
//  https://talk.objc.io/episodes/S01E173-building-a-shake-animation

import Foundation
import SwiftUI

struct Shake: GeometryEffect {
    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(CGAffineTransform(translationX: -10 * sin(position * 2 * .pi), y: 0))
    }
    
    init(shakes: Int) {
        position = CGFloat(shakes)
    }
    
    var position: CGFloat
    var animatableData: CGFloat {
        get { position }
        set { position = newValue }
    }
}
