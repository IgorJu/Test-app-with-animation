//
//  ViewController.swift
//  Test app with animation
//
//  Created by Igor on 05.03.2024.
//

import UIKit

final class ViewController: UIViewController {
    private let verticalListTableView = UITableView()
    private var randomLists: [[Int]] = []
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(verticalListTableView)
        setConstraints()
        
        verticalListTableView.dataSource = self
        verticalListTableView.register(HorizontalListCell.self, forCellReuseIdentifier: "HorizontalListCell")
        verticalListTableView.rowHeight = 150
        verticalListTableView.estimatedRowHeight = 150
        
        generateRandomLists()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateRandomNumbers), userInfo: nil, repeats: true)
    }
    
    deinit {
        timer?.invalidate()
    }
}

//MARK: - setup UI
private extension ViewController {
    func setConstraints() {
        verticalListTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            verticalListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            verticalListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

//MARK: - Random Numbers Logic
private extension ViewController {
    func generateRandomLists() {
        let verticalListCount = Int.random(in: 100...200)
        randomLists = (0..<verticalListCount).map { _ in
            return (0..<Int.random(in: 10...20)).map { _ in
                return Int.random(in: 0...100)
            }
        }
        verticalListTableView.reloadData()
    }
    
    @objc func updateRandomNumbers() {
        for index in randomLists.indices {
            guard let randomIndex = randomLists[index].indices.randomElement() else {
                continue
            }
            randomLists[index][randomIndex] = Int.random(in: 0...100)
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = verticalListTableView.cellForRow(at: indexPath) as? HorizontalListCell {
                cell.numbers = randomLists[index]
            }
        }
    }
}

//MARK: - VC dataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HorizontalListCell", for: indexPath) as! HorizontalListCell
        cell.numbers = randomLists[indexPath.row]
        
        return cell
    }
}
