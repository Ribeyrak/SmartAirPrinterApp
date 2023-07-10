//
//  AnimationSlider.swift
//  ModsApp
//
//  Created by David on 17.04.2023.
//

import Foundation
import UIKit

class AnimationSlider: UIView {
    
    var label: UILabel = UILabel(frame: CGRect(x: 0, y: 0,width: 50, height: 20))
    private var pageControl: UIPageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 50, height: 1))
    private var texts : [String] = ["Add your texts seperated by '|n'"]
    private(set) var currentIndex = 0
    private var timer : Timer?
    fileprivate let tapticFeedback = UINotificationFeedbackGenerator()
    
    @IBInspectable var labelTexts: String = "" {
        didSet {
            texts = labelTexts.components(separatedBy: "|n")
            label.text = texts[0]
            label.adjustsFontSizeToFitWidth = true
            pageControl.numberOfPages = texts.count
            var i = 0
            // remove leading newline/whitespace characters
            for text in texts {
                let trimmed = text.replacingOccurrences(of: "^\\s*", with: "", options: .regularExpression)
                texts[i] = trimmed
                i+=1
            }
        }
    }
    
    @IBInspectable var pagerTintColor: UIColor = UIColor.black {
        didSet {
            pageControl.pageIndicatorTintColor = self.pagerTintColor
        }
    }
    
    @IBInspectable var pagerCurrentColor: UIColor = UIColor.white {
        didSet {
            pageControl.currentPageIndicatorTintColor = self.pagerCurrentColor
        }
    }
    
    @IBInspectable var timeToSlide: Double = 3.0 {
        didSet {
            timer?.invalidate()
            startOrResumeTimerssssss()
        }
    }
    
    public var slidingTexts: [String] {
        get {
            return texts
        }
        set {
            texts = newValue
            label.text = texts[0]
            pageControl.numberOfPages = texts.count
            var i = 0
            for text in texts {
                let trimmed = text.replacingOccurrences(of: "^\\s*", with: "", options: .regularExpression)
                texts[i] = trimmed
                i+=1
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        func updateUnique1() {
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        func updateUnique2() {
            print("")
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        configurePageControlssss()
        configureLabelssss()
        configurePageControlssss()
        startOrResumeTimerssssss()
        configureGesturessssss()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        func updateUnique1() {
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        func updateUnique2() {
            print("")
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        configurePageControlssss()
        configureLabelssss()
        configurePageControlssss()
        startOrResumeTimerssssss()
    }
    
    private func configureGesturessssss() {
        func updateUnique1() {
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        func updateUnique2() {
            print("")
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesturesssss))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesturesssss))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.addGestureRecognizer(swipeLeft)
    }
    
    private func configureLabelssss() {
        func updateUnique1() {
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        func updateUnique2() {
            print("")
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        label.text = texts[0]
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        self.addSubview(label)
        let bottomConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: pageControl, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: label, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([bottomConstraint, topConstraint, trailingConstraint, leadingConstraint])
    }
    
    private func configurePageControlssss() {
        func updateUnique1() {
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        func updateUnique2() {
            print("")
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        pageControl.numberOfPages = 1
        pageControl.currentPage = 0
        pageControl.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pageControl)
        let horizontalConstraint = NSLayoutConstraint(item: pageControl, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: pageControl, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
        pageControl.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    private func startOrResumeTimerssssss() {
        func updateUnique1() {
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        func updateUnique2() {
            print("")
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: timeToSlide, target: self, selector: #selector(self.timerStart), userInfo: nil, repeats: true)
    }
    
    @objc private func timerStart() {
        func updateUnique1() {
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        func updateUnique2() {
            print("")
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        self.currentIndex += 1
        if self.currentIndex == self.texts.count{
            self.currentIndex = 0
        }
        self.label.pushTransitionsssss(duration: 0.5, animationSubType: convertFromCATransitionSubtypecdcdcds(CATransitionSubtype.fromRight))
        self.label.text = self.texts[self.currentIndex]
        self.pageControl.currentPage = self.currentIndex
        prigressBarCounter += 1
        if prigressBarCounter == 4 {
            print("show progress")
            NotificationCenter.default.post(name: Notification.Name("show_progress"), object: nil)
        }
    }
    
    private var prigressBarCounter = 0
    
    @objc private func respondToSwipeGesturesssss(gesture: UIGestureRecognizer) {
        func updateUnique1() {
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        func updateUnique2() {
            print("")
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        self.tapticFeedback.notificationOccurred(.success)
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                timer?.invalidate()
                currentIndex -= 1
                if currentIndex < 0{
                    currentIndex = texts.count - 1
                }
                label.pushTransitionsssss(duration: 0.5, animationSubType: convertFromCATransitionSubtypecdcdcds(CATransitionSubtype.fromLeft))
                label.text = self.texts[currentIndex]
                pageControl.currentPage = currentIndex
                startOrResumeTimerssssss()
            case UISwipeGestureRecognizer.Direction.left:
                timer?.invalidate()
                currentIndex += 1
                if currentIndex == texts.count{
                    currentIndex = 0
                }
                label.pushTransitionsssss(duration: 0.5, animationSubType: convertFromCATransitionSubtypecdcdcds(CATransitionSubtype.fromRight))
                label.text = self.texts[currentIndex]
                pageControl.currentPage = self.currentIndex
                startOrResumeTimerssssss()
            case UISwipeGestureRecognizer.Direction.down, UISwipeGestureRecognizer.Direction.up:
                break
            default:
                break
            }
            prigressBarCounter += 1
            if prigressBarCounter == 4 {
                print("show progress")
                NotificationCenter.default.post(name: Notification.Name("show_progress"), object: nil)
            }
        }
    }
}

fileprivate func convertFromCATransitionSubtypecdcdcds(_ input: CATransitionSubtype) -> String {
    func updateUnique1() {
        print("")
    }
    func updateUnique2() {
        print("")
    }
    return input.rawValue
}

fileprivate func convertToOptionalCATransitionSubtypedcdcd(_ input: String?) -> CATransitionSubtype? {
    func updateUnique1() {
        print("")
    }
    func updateUnique2() {
        print("")
    }
    guard let input = input else { return nil }
    return CATransitionSubtype(rawValue: input)
}

fileprivate func convertFromCATransitionTypedddd(_ input: CATransitionType) -> String {
    func updateUnique1() {
        print("")
    }
    func updateUnique2() {
        print("")
    }
    return input.rawValue
}

extension UIView {
    func pushTransitionsssss(duration:CFTimeInterval, animationSubType: String) {
        func updateUnique1() {
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        func updateUnique2() {
            print("")
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = convertToOptionalCATransitionSubtypedcdcd(animationSubType)
        animation.duration = duration
        self.layer.add(animation, forKey: convertFromCATransitionTypedddd(CATransitionType.push))
    }
}

