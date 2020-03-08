//
//  GridReloadAnimatorFactory.swift
//  G
//
//  Created by Eugene on 19.02.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

public enum GridReloadAnimatorFactory {
    
    case`default`(itemDelay: TimeInterval, animator: GridReloadAnimator)
    case custom(animatorManager: GridReloadAnimatorManager)
    
    var animatorManager: GridReloadAnimatorManager {
        switch self {
        case let .default(itemDelay, animator):
            return GridReloadAnimatorManagerImp(itemDelay: itemDelay,
                                                animator: animator)
        case let .custom(animatorManager):
            return animatorManager
        }
    }
    
}


// MARK: - Predefined animators
public extension GridReloadAnimatorFactory {
    
    static func bottom(itemDelay: TimeInterval = 0.09,
                       duration: TimeInterval = 0.6,
                       dampingRatio: CGFloat = 1,
                       initialVelocity: CGFloat = 1,
                       options: UIView.AnimationOptions = [],
                       alpha: CGFloat = 1) -> GridReloadAnimatorFactory {
        
        let animator = GridBottomAnimator(duration: duration,
                                          dampingRatio: dampingRatio,
                                          initialVelocity: initialVelocity,
                                          options: options,
                                          alpha: alpha)
        
        return .default(itemDelay: itemDelay, animator: animator)
    }
    
    
    static func right(itemDelay: TimeInterval = 0.09,
                      duration: TimeInterval = 0.6,
                      dampingRatio: CGFloat = 1,
                      initialVelocity: CGFloat = 1,
                      options: UIView.AnimationOptions = [],
                      alpha: CGFloat = 1) -> GridReloadAnimatorFactory {
        
        let animator = GridRightAnimator(duration: duration,
                                         dampingRatio: dampingRatio,
                                         initialVelocity: initialVelocity,
                                         options: options,
                                         alpha: alpha)
        
        return .default(itemDelay: itemDelay, animator: animator)
    }
    
    
    static func fade(itemDelay: TimeInterval = 0.09,
                     duration: TimeInterval = 0.5,
                     options: UIView.AnimationOptions = []) -> GridReloadAnimatorFactory {
        
        let animator = GridFadeAnimator(duration: duration, options: options)
        return .default(itemDelay: itemDelay, animator: animator)
    }
    
}
