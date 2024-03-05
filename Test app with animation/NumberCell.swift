//
//  NumberCell.swift
//  Test app with animation
//
//  Created by Igor on 05.03.2024.
//

import UIKit

final class NumberCell: UICollectionViewCell {
    var number: Int = 0 {
        didSet {
            numberLabel.text = "\(number)"
        }
    }
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(numberLabel)
        setConstraints()
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        numberLabel.text = nil
    }
}

//MARK: - Constraints
private extension NumberCell {
    func setConstraints() {
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            numberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            numberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
