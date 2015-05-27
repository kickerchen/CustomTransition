//
//  ClimberProfileViewController.swift
//  BoulderTransition
//
//  Created by CHENCHIAN on 5/22/15.
//  Copyright (c) 2015 KICKERCHEN. All rights reserved.
//

import Foundation
import UIKit

class ClimberProfileViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileTextView: UITextView!
    @IBOutlet weak var descriptionView: UIView!

    
    var climber: Climbers!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        bgView.image = UIImage(named: climber.image)
        nameLabel.text = climber.name
        var profile = NSString(format: "Nationality: %@\nBirth Year: %@\nHeight: %@\nWeight: %@", climber.nationality, climber.birthyear, climber.height, climber.weight)
        constructTextView(profile as String)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("tapAction:")))
    }
    
    func constructTextView(text: String) {
        
        let font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        let textColor = UIColor.whiteColor()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .Center
        
        let attributes = [
            NSParagraphStyleAttributeName : paragraphStyle,
            NSForegroundColorAttributeName : textColor,
            NSFontAttributeName : font,
        ]
        
        profileTextView.attributedText = NSAttributedString(string: text, attributes: attributes)
    }
    
    func tapAction(tap: UITapGestureRecognizer) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setDescriptionViewAlpha(alpha: CGFloat) {
        descriptionView.alpha = alpha
    }
}