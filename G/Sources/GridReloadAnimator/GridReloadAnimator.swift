//
//  GridReloadAnimator.swift
//  G
//
//  Created by Eugene on 19.02.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

public protocol GridReloadAnimator {
    
    func animate(_ cell: UIView, delay: TimeInterval, gridRect: CGRect)
}

public struct GridBottomAnimator: GridReloadAnimator {
    
    let duration: TimeInterval
    let dampingRatio: CGFloat
    let initialVelocity: CGFloat
    let options: UIView.AnimationOptions
    let alpha: CGFloat
    
    public func animate(_ cell: UIView, delay: TimeInterval, gridRect: CGRect) {
        
        cell.alpha = self.alpha
        cell.transform = .init(translationX: 0, y: gridRect.height)
        
        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: dampingRatio,
                       initialSpringVelocity: initialVelocity,
                       options: options, animations: {
                        
                        cell.alpha = 1
                        cell.transform = .identity
        })
        
    }
}

public struct GridRightAnimator: GridReloadAnimator {
    
    let duration: TimeInterval
    let dampingRatio: CGFloat
    let initialVelocity: CGFloat
    let options: UIView.AnimationOptions
    let alpha: CGFloat
    
    public func animate(_ cell: UIView, delay: TimeInterval, gridRect: CGRect) {
        
        cell.alpha = alpha
        cell.transform = .init(translationX: gridRect.width, y: 0)

        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: dampingRatio,
                       initialSpringVelocity: initialVelocity,
                       options: options, animations: {
                        
                        cell.alpha = 1
                        cell.transform = .identity
        })
        
    }
}

public struct GridFadeAnimator: GridReloadAnimator {
    
    let duration: TimeInterval
    let options: UIView.AnimationOptions
    
    public init(duration: TimeInterval, options: UIView.AnimationOptions) {
        self.duration = duration
        self.options = options
    }
    
    public func animate(_ cell: UIView, delay: TimeInterval, gridRect: CGRect) {
        
        cell.alpha = 0
        
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
            cell.alpha = 1
            cell.transform = .identity
        })
        
    }
}
