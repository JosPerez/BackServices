//
//  STPRingViewList.swift
//  BackServices
//
//  Created by jose perez on 08/02/23.
//
import UIKit

// - MARK: Ring View List
public class RingViewList: UIView {
    
    private var tableView: UITableView!
    private var ringView: RingView!
    
    public var dataSource: RingViewDataSource? {
        didSet {
            ringView.dataSource = dataSource
        }
    }
    
    override init(frame: CGRect) {
        ringView = RingView()
        tableView = UITableView()
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        ringView = RingView()
        tableView = UITableView()
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        // Setup tablebiew
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        // Assign size to RingView
        ringView.translatesAutoresizingMaskIntoConstraints = false
        // Add RingView and tableView as subviews
        addSubview(ringView)
        addSubview(tableView)
        
        // Constraints for RingView
        NSLayoutConstraint.activate([
            ringView.topAnchor.constraint(equalTo: topAnchor),
            ringView.leadingAnchor.constraint(equalTo: leadingAnchor),
            ringView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ringView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
        
        // Constraints for UITableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: ringView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        // Assing Color
        ringView.backgroundColor = .white
        tableView.backgroundColor = .white
    }
}


extension RingViewList: UITableViewDataSource, UITableViewDelegate, RingViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.numberOfParts(in: ringView) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let part = dataSource?.ringView(ringView, partAt: indexPath.row)
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as?  CustomTableViewCell {
            cell.label.text = part?.name
            cell.circularView.backgroundColor = part?.color
            return cell
        }
        return UITableViewCell()
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    public func numberOfParts(in ringView: RingView) -> Int {
        return dataSource?.numberOfParts(in: ringView) ?? 0
    }
    
    public func ringView(_ ringView: RingView, partAt index: Int) -> Part {
        return dataSource?.ringView(ringView, partAt: index) ?? Part(quantity: 0, color: .clear, name: "")
    }
    
    public func ringView(_ ringView: RingView, labelsFor centerLabel: inout (up: UILabel, down: UILabel)) {
        dataSource?.ringView(ringView, labelsFor: &centerLabel)
    }
}

// -MARK: - Table view cell
class CustomTableViewCell: UITableViewCell {
    let circularView = UIView()
    let label = UILabel()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {        
        circularView.layer.cornerRadius = 12.5
        circularView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(circularView)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            circularView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            circularView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: (bounds.width / 2) - 16),
            circularView.widthAnchor.constraint(equalToConstant: 25),
            circularView.heightAnchor.constraint(equalToConstant: 25),
            
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: circularView.trailingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
