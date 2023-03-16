//
//  VBSBarGraphView.swift
//  BackServices
//
//  Created by jose perez on 13/03/23.
//
import UIKit
public protocol VBSBarGraphViewDataSource: AnyObject {
    func numberOfBars(in barGraphView: VBSBarGraphView) -> Int
    func barGraphView(_ barGraphView: VBSBarGraphView, nameForBarAt index: Int) -> String
    func barGraphView(_ barGraphView: VBSBarGraphView, quantityForBarAt index: Int) -> Double
}

public class VBSBarGraphView: UIView {
    
    public weak var dataSource: VBSBarGraphViewDataSource?
    
    var barColor: UIColor = .blue
    var barSpacing: CGFloat = 10.0
    var barWidth: CGFloat = 30.0
    var scaleFont: UIFont = .systemFont(ofSize: 12.0)
    var labelFont: UIFont = .systemFont(ofSize: 14.0)
    var labelHeight: CGFloat = 40.0
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let dataSource = dataSource else { return }
        
        let numberOfBars = dataSource.numberOfBars(in: self)
        let maxValue = getMaxValue(dataSource: dataSource, numberOfBars: numberOfBars)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(barColor.cgColor)
        
        let totalBarWidth = CGFloat(numberOfBars) * barWidth + CGFloat(numberOfBars - 1) * barSpacing
        var xOffset = (bounds.width - totalBarWidth) / 2.0
        
        for i in 0..<numberOfBars {
            let name = dataSource.barGraphView(self, nameForBarAt: i)
            let value = dataSource.barGraphView(self, quantityForBarAt: i)
            let barHeight = value / maxValue * (bounds.height - labelHeight)
            let barX = xOffset
            let barY = bounds.height - barHeight - labelHeight
            
            let barRect = CGRect(x: barX, y: barY, width: barWidth, height: barHeight)
            context?.fill(barRect)
            
            let scaleLabel = UILabel(frame: CGRect(x: barX, y: bounds.height - labelHeight, width: barWidth, height: labelHeight))
            scaleLabel.textAlignment = .center
            scaleLabel.font = scaleFont
            scaleLabel.text = String(format: "%.0f", value)
            addSubview(scaleLabel)
            
            let label = UILabel(frame: CGRect(x: barX, y: bounds.height - labelHeight, width: barWidth, height: labelHeight))
            label.textAlignment = .center
            label.font = labelFont
            label.text = name
            label.numberOfLines = 2
            addSubview(label)
            
            xOffset += barWidth + barSpacing
        }
    }
    
    private func getMaxValue(dataSource: VBSBarGraphViewDataSource, numberOfBars: Int) -> Double {
        var maxValue: Double = 0.0
        
        for i in 0..<numberOfBars {
            let value = dataSource.barGraphView(self, quantityForBarAt: i)
            if value > maxValue {
                maxValue = value
            }
        }
        
        return maxValue
    }
}
