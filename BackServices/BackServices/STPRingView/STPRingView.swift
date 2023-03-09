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
    
    var ringWidth: CGFloat = 20
    public var dataSource: RingViewDataSource?
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
        guard let dataSource = dataSource else { return }
        let numberOfParts = dataSource.numberOfParts(in: self)
        guard numberOfParts > 0 else { return }
        
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2 - ringWidth / 2
        let startAngle: CGFloat = CGFloat.pi
        let endAngle = 3 * CGFloat.pi
        totalQuantity = (0..<numberOfParts).reduce(0) { $0 + dataSource.ringView(self, partAt: $1).quantity }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let formattedPrice = formatter.string(from: NSNumber(value: totalQuantity)) {
            centerLabels?.down.text = formattedPrice
        }
        
        var cumulativeQuantity: Double = 0
        
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
            path.lineCapStyle = .round
            path.lineWidth = ringWidth
            part.color.setStroke()
            path.stroke()
        }
    }
}

