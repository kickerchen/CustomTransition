//
//  ViewController.swift
//  BoulderTransition
//
//  Created by CHENCHIAN on 5/22/15.
//  Copyright (c) 2015 KICKERCHEN. All rights reserved.
//

import UIKit

let kScrollSubviewBaseTagNumber: Int = 10

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var bgView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let climbers = Climbers.all()
    let transition = CustomTransition()
    var selectedImageView: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.sendSubviewToBack(bgView)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if (scrollView.subviews.count < climbers.count) {
            setupScrollView()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Internal Methods

    // add climbers image to scrollview
    func setupScrollView() {
        
        for (var i = 0; i < climbers.count; i++) {
            
            let imageView = UIImageView()
            imageView.tag = i + kScrollSubviewBaseTagNumber
            imageView.userInteractionEnabled = true
            imageView.layer.cornerRadius = 20.0
            imageView.contentMode = .ScaleAspectFill
            imageView.clipsToBounds = true
            scrollView.addSubview(imageView)
            
            // add tap recognizer
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("tapOnImage:")))
            
            imageView.image = UIImage(named: climbers[i].image)
            //asyncLoadImage(climbers[i].imageUrl, imageView: imageView)
        }
        
        scrollView.backgroundColor = UIColor.clearColor()
        positionClimberImage()
    }

    // calculate position of each image
    func positionClimberImage() {
        
        let imageHeight = scrollView.frame.height * 1.33
        let imageWidth = imageHeight / 1.5
        let xPadding: CGFloat = 10.0
        
        // content frame
        for (var i = 0; i < climbers.count; i++) {
            let imageView = scrollView.viewWithTag(i + kScrollSubviewBaseTagNumber) as! UIImageView
            imageView.frame = CGRect(x: CGFloat(i) * imageWidth + CGFloat(i+1) * xPadding,
                y: 0.0, width: imageWidth, height: imageHeight)
        }
        
        // content size
        scrollView.contentSize = CGSize(width: CGFloat(climbers.count) * (imageWidth + xPadding) + xPadding,
            height: 0)
    }
    
    // async load image
    func asyncLoadImage(imageUrl: String, imageView: UIImageView) {
        
        let loadImageQueue = dispatch_queue_create("com.BoulderTransition.loadImageQueue", nil)
        dispatch_async(loadImageQueue) {
            
            var data = NSData(contentsOfURL: NSURL(string: imageUrl)!)
            var image: UIImage?
            if let realData = data {
                image = UIImage(data: realData)
            }
            
            dispatch_async(dispatch_get_main_queue()){
                imageView.image = image
            }
        }
    }
    
    // MARK: - Action Methods
    func tapOnImage(tap: UITapGestureRecognizer) {
        
        selectedImageView = tap.view as? UIImageView
        let index = tap.view!.tag - kScrollSubviewBaseTagNumber
        let selectedClimber = climbers[index]
        
        let climberProfile = storyboard!.instantiateViewControllerWithIdentifier("ClimberProfileViewController") as! ClimberProfileViewController
        climberProfile.climber = selectedClimber
        climberProfile.transitioningDelegate = self
        presentViewController(climberProfile, animated: true, completion: nil)
    }
}


extension ViewController : UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.originFrame = selectedImageView!.superview!.convertRect(selectedImageView!.frame, toView: nil)
        transition.selectedImageView = selectedImageView
        transition.presenting = true
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.presenting = false
        return transition
    }
}
