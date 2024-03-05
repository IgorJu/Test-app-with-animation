//
//  HorizontalListCell.swift
//  Test app with animation
//
//  Created by Igor on 05.03.2024.
//

import UIKit

final class HorizontalListCell: UITableViewCell {
    var numbers: [Int] = [] {
        didSet {
            if !isLongPressing {
                collectionView.reloadData()
            }
        }
    }
    
    private var isLongPressing = false
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.register(NumberCell.self, forCellWithReuseIdentifier: "NumberCell")
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLongPressGesture()
        contentView.addSubview(collectionView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        numbers = []
    }
}

private extension HorizontalListCell {
    func setupLongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:)))
        collectionView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        guard let targetIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else { return }
        
        switch gesture.state {
        case .began:
            isLongPressing = true
            animateCell(at: targetIndexPath, scale: 0.8)
        case .ended, .cancelled:
            isLongPressing = false
            animateCell(at: targetIndexPath, scale: 1.0)
        default:
            break
        }
    }
    
    func animateCell(at indexPath: IndexPath, scale: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            if let cell = self.collectionView.cellForItem(at: indexPath) {
                cell.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
    }
}


//MARK: - Setup UI
private extension HorizontalListCell {
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}

//MARK: - DataSource, delegate
extension HorizontalListCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NumberCell", for: indexPath) as! NumberCell
        cell.number = numbers[indexPath.item]
        return cell
    }
}
