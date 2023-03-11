//
//  STPRingView.swift
//  BackServices
//
//  Created by jose perez on 08/02/23.
//
import UIKit

// - MARK: Ring view Data source protocol
public protocol RingViewDataSource: AnyObject {
    func numberOfParts(in ringView: RingView) -> Int
    func ringView(_ ringView: RingView, partAt index: Int) -> Part
    func ringView(_ ringView: RingView, labelsFor centerLabel: inout (up: UILabel, down: UILabel))
}
// - MARK: Part Struct
public struct Part {
    public var quantity: Double
    public var color: UIColor
    public var name: String
    public init (quantity: Double, color: UIColor, name: String) {
        self.quantity = quantity
        self.color = color
        self.name = name
    }
}
// - MARK: Ring view
public class RingView: UIView {
    public var lineCapStyle: CGLineCap = .butt
    public var ringWidth: CGFloat = 20 
    public var dataSource: RingViewDataSource? {
        didSet {
            reloadData()
        }
    }
    var totalQuantity: Double = 0
    var centerLabels: (up: UILabel, down: UILabel)?
    var labelRadius: CGFloat = 16
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if centerLabels == nil {
            let centerX = bounds.width / 2
            let centerY = bounds.height / 2
            let widthFix = min(bounds.width, bounds.height)  - (ringWidth * 2)
            var labelCenter = CGPoint(x: centerX - widthFix / 2, y: centerY - labelRadius)
            let centerLabel1 = UILabel(frame: CGRect(x: labelCenter.x + 4 , y: labelCenter.y - 8, width: widthFix - 4, height: 24))
            labelCenter = CGPoint(x: centerX - widthFix / 2, y: centerY + labelRadius)
            let centerLabel2 = UILabel(frame: CGRect(x: labelCenter.x + 4, y: labelCenter.y - 16, width: widthFix - 4, height: 24))
            centerLabel1.textAlignment = .center
            centerLabel1.adjustsFontSizeToFitWidth = true
            centerLabel2.textAlignment = .center
            centerLabel2.adjustsFontSizeToFitWidth = true
            centerLabels = (centerLabel1, centerLabel2)
            addSubview(centerLabel1)
            addSubview(centerLabel2)
        }
        
        guard let dataSource = dataSource else { return }
        dataSource.ringView(self, labelsFor: &centerLabels!)
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let dataSource = dataSource else {
            print("No se encontro")
            return
        }
        let numberOfParts = dataSource.numberOfParts(in: self)
        guard numberOfParts > 0 else {
            print("No hay información de segmentos")
            return
        }
        
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2 - ringWidth / 2
        let startAngle: CGFloat = CGFloat.pi
        let endAngle = 3 * CGFloat.pi
        totalQuantity = (0..<numberOfParts).reduce(0) { $0 + dataSource.ringView(self, partAt: $1).quantity }
        
        guard totalQuantity > 0 else {
            let path = UIBezierPath(arcCenter: center,
                                    radius: radius,
                                    startAngle: startAngle,
                                    endAngle: endAngle,
                                    clockwise: true
            )
            path.lineCapStyle = lineCapStyle
            path.lineWidth = ringWidth
//            UIColor.lightGray.setStroke()
//            path.stroke()
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.strokeColor = UIColor.lightGray.cgColor
            shapeLayer.lineWidth = ringWidth
            shapeLayer.fillColor = UIColor.clear.cgColor
            self.layer.addSublayer(shapeLayer)
            let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
            strokeEndAnimation.duration = 1.5
            strokeEndAnimation.fromValue = 0.0
            strokeEndAnimation.toValue = 1.0
            strokeEndAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            shapeLayer.add(strokeEndAnimation, forKey: "strokeEndAnimation")
            return
        }
        
        var cumulativeQuantity: Double = 0
        var shapeLayers = [CAShapeLayer]()

        for i in 0..<numberOfParts {
            let part = dataSource.ringView(self, partAt: i)
            let partStartAngle = startAngle + CGFloat(Float(cumulativeQuantity / totalQuantity) * Float(endAngle - startAngle))
            cumulativeQuantity += part.quantity
            let partEndAngle = startAngle + CGFloat(Float(cumulativeQuantity / totalQuantity) * Float(endAngle - startAngle))
            
            let path = UIBezierPath(arcCenter: center,
                                    radius: radius,
                                    startAngle: partStartAngle,
                                    endAngle: partEndAngle,
                                    clockwise: true
            )
//            path.lineCapStyle = .butt
//            path.lineWidth = ringWidth
//            part.color.setStroke()
//            path.stroke()
            path.lineCapStyle = .butt
            path.lineWidth = ringWidth
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.strokeColor = part.color.cgColor
            shapeLayer.lineWidth = ringWidth
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayers.append(shapeLayer)
        }
        for shapeLayer in shapeLayers {
            self.layer.addSublayer(shapeLayer)
        }
        let delayIncrement = 0.3
        var delay = 0.0
        for shapeLayer in shapeLayers {
            let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
            strokeEndAnimation.duration = 2.0
            strokeEndAnimation.fromValue = 0.0
            strokeEndAnimation.toValue = 1.0
            strokeEndAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            shapeLayer.add(strokeEndAnimation, forKey: "strokeEndAnimation")
            strokeEndAnimation.beginTime = CACurrentMediaTime() + delay
            delay += delayIncrement
        }
    }
    public func reloadData() {
        setNeedsDisplay()
        setNeedsLayout()
    }
}


