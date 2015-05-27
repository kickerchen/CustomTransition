//
//  CustomTransition.swift
//  BoulderTransition
//
//  Created by CHENCHIAN on 5/26/15.
//  Copyright (c) 2015 KICKERCHEN. All rights reserved.
//

import Foundation
import UIKit

class CustomTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zeroRect
    var selectedImageView: UIImageView?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    
        let containerView = transitionContext.containerView()
        
        // get views
        let destinationView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let climberProfileView = presenting ? destinationView : transitionContext.viewForKey(UITransitionContextFromViewKey)!
        
        // get view controllers
        let climberProfileViewController = presenting ? transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! ClimberProfileViewController : transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ClimberProfileViewController
        
        // get frames
        let initialFrame = presenting ? originFrame : climberProfileView.frame
        let finalFrame = presenting ? climberProfileView.frame : originFrame
        
        // derive factors
        let xScaleFactor = originFrame.width / climberProfileView.frame.width
        let yScaleFactor = originFrame.height / climberProfileView.frame.height
        
        // construct transform
        let downScaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor)
        
        if presenting {
            
            // scale down
            climberProfileView.transform = downScaleTransform
            
            // move climber profile view to initial position before animation
            climberProfileView.center = CGPoint(
                x: CGRectGetMidX(initialFrame),
                y: CGRectGetMidY(initialFrame))                
            
            climberProfileView.clipsToBounds = true
            
        } else {
            // hide tapped images during transitions so it really looks like they grow to take up the full screen
            selectedImageView?.hidden = true
        }
        
        // hide climber description
        climberProfileViewController.setDescriptionViewAlpha(0.0)
        
        containerView.addSubview(destinationView)
        containerView.bringSubviewToFront(climberProfileView)
        
        // perform animation
        UIView.animateWithDuration(duration, delay: 0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.0,
            options: nil,
            animations: {
                
                climberProfileView.transform = self.presenting ? CGAffineTransformIdentity : downScaleTransform

                climberProfileView.center = CGPoint(
                    x: CGRectGetMidX(finalFrame),
                    y: CGRectGetMidY(finalFrame)
                )
                
            }, completion: { _ in
                
                if !self.presenting {
                    // show tapped images
                    self.selectedImageView?.hidden = false
                }
                
                // fade in climber description after pop-out animation
                if self.presenting {
                    UIView.animateWithDuration(0.5, animations: {
                        climberProfileViewController.setDescriptionViewAlpha(0.5)
                    })
                }
                
                transitionContext.completeTransition(true)
                
        })
    }
}