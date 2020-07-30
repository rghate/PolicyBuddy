//
//  CircularCountdownProgrssbar.swift
//  PolicyBuddy
//
//  Created by Rupali on 20/07/2020.
//  Copyright © 2020 rghate. All rights reserved.
//

import UIKit

@objc protocol CountdownProgressDelegate: class {
    @objc optional func counDownProgressUpdate(time: Int, type: String)
    func countdownComplete()
}

@IBDesignable
class CircularCountdownProgrssbar: UIView {
    
    // MARK: Public properties
    
    weak var delegate: CountdownProgressDelegate?
    
    //        @IBInspectable
    var circleSize: CGFloat = 14 {
        didSet {
            setupViews()
        }
    }
    
    var barColor: UIColor = Color.SECONDARY_BUTTON_TEXT_COLOR {
        didSet {
            descriptionLabel.textColor = barColor
        }
    }
    
    var showDescriptionText: Bool = true {
        didSet {
            descriptionLabel.isHidden = true
        }
    }
    
    
    // MARK: Private properties
    
    private var shapeLayer: CAShapeLayer!
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var timer: Timer?
    
    private var timeDifference: CalenderComponent = CalenderComponent()
    
    private var startDate: Date = Date()
    
    private var endDate: Date = Date()
    
    private var intervalType: Date.IntervalType = .Minutes
    
    private var hightestThresholdForType: Float = 0
    
    private var maxDurationValue: Int = 0
    
    private var timeIntervalInSeconds: TimeInterval = 1
    
    
    
    // MARK: Public Methods
    
    func animate(withendDate endDate: Date) {
        setupViews()
        
        self.startDate = Date()
        
        guard startDate < endDate else { return }   // TODO: Test case
        
        self.endDate = endDate
        
        print("Start date: ", self.startDate)
        print("End date: ", self.endDate)
        
        self.intervalType = calculateIntervalParams()
        
        beginCountdown()
    }
    
    func endCountdown(completion:()->Void) {
        timer?.invalidate()
        completion()
    }
    
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    
    // MARK: Action handlers
    
    @objc func handleTimeout() {
        let intervalType = calculateIntervalParams()
        
        DispatchQueue.main.async {
            self.shapeLayer.strokeEnd = CGFloat(Float(self.maxDurationValue)/self.hightestThresholdForType)
            if self.showDescriptionText {
                self.descriptionLabel.text = "\(Int(self.maxDurationValue))" + " \(self.intervalType.description) remaining"
            }
        }
        
        // if countdown completed
        if intervalType == .NONE {
            timer?.invalidate()
            delegate?.countdownComplete()
            return
        } else {
            beginCountdown()
        }
    }
    
    
    // MARK: Private methods
    
    private func beginCountdown() {
        timer?.invalidate()
        
        // if intervalType is in days, schedule and hourly timer. If intervalType is in hours, schedule a minute timer (to check and repeat every minute)
        // This is to avoid doing all the calculations every second
        timeIntervalInSeconds = (intervalType == .Days) ? 60 * 60 :
            (intervalType == .Hours) ? 60:
            (intervalType == .Minutes || intervalType == .Seconds) ? 1 : 1
        
        if showDescriptionText {
            self.descriptionLabel.text = "\(Int(self.maxDurationValue))" + " \(self.intervalType.description.lowercased()) remaining"
        }
        shapeLayer.strokeEnd = CGFloat(Float(self.maxDurationValue)/hightestThresholdForType)
        
        self.delegate?.counDownProgressUpdate?(time: self.maxDurationValue, type: intervalType.description)
        
        timer = Timer.scheduledTimer(timeInterval: timeIntervalInSeconds, target: self, selector: #selector(handleTimeout), userInfo: nil, repeats: true)
    }
    
    private func setupViews() {
        backgroundColor = .clear
        
        let circularShapeView = setupCircleShapeView()
        
        // Add circleShapView and descriptionLabel in a horizonal stackview
        let stackView = UIStackView(arrangedSubviews: [circularShapeView, descriptionLabel])
        stackView.axis = .horizontal
        addSubview(stackView)
        stackView.fillSuperview()
        
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 20
    }
    
    private func setupCircleShapeView() -> UIView {
        let shapeView = UIView()
        
        shapeView.backgroundColor = .clear
        shapeView.translatesAutoresizingMaskIntoConstraints = false
        
        let trackLayer = createCircleShapeLayer(strokeColor: UIColor.lightGray, fillColor: UIColor.clear)
        shapeView.layer.addSublayer(trackLayer)
        
        //setup shape for circular animation
        shapeLayer = createCircleShapeLayer(strokeColor: barColor, fillColor: .clear)
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2.0, 0, 0, 1)
        
        shapeLayer.strokeEnd = 0    //reset drawing on screen launch
        shapeView.layer.addSublayer(shapeLayer)
        
        trackLayer.anchorPoint = CGPoint(x: 0, y: 0)
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
        
        trackLayer.position = shapeView.center
        shapeLayer.position = shapeView.center
        
        trackLayer.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: circleSize, height: circleSize)).cgPath
        
        return shapeView
    }
    
    private func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: circleSize/2, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 3
        layer.fillColor = fillColor.cgColor
        layer.position = center
        layer.lineCap = CAShapeLayerLineCap.round    //to make stroke smoother
        
        layer.path = UIBezierPath(ovalIn: CGRect(x: -circleSize, y: 0, width: circleSize, height: circleSize)).cgPath
        
        return layer
    }
    
    
    private func calculateIntervalParams() -> Date.IntervalType {
        let startDate = Date()
        
        // get time difference between start and end date in number of days, hours, minutes and seconds
        timeDifference = endDate.offsetFrom(date: startDate)
        
        intervalType = decideIntervalType(component: timeDifference)
        
        switch intervalType {
        case .Days:
            maxDurationValue = timeDifference.days
            hightestThresholdForType = 0
        case .Hours:
            maxDurationValue = timeDifference.hours
            hightestThresholdForType = 24
        case .Minutes:
            maxDurationValue = timeDifference.minutes
            hightestThresholdForType = 60
        case .Seconds:
            maxDurationValue = timeDifference.seconds
            hightestThresholdForType = 60
        case .NONE:
            maxDurationValue = 0
        }
        return intervalType
    }
    
    private func decideIntervalType(component: CalenderComponent) -> Date.IntervalType {
        return component.days > 0 ? .Days :
            component.hours > 0 ? .Hours :
            component.minutes > 0 ? .Minutes :
            component.seconds > 0 ? .Seconds :
            .NONE
    }
}
