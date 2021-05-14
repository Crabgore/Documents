//
//  TableViewCell.swift
//  Documents
//
//  Created by Mihail on 14.05.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var file: URL? {
        didSet {
            title.text = "File name: \(String(file?.lastPathComponent ?? ""))"
            path.text = "File path: \(String(file?.absoluteString ?? ""))"
        }
    }

    private let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let path: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(title)
        contentView.addSubview(path)
        
        let constraints = [
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            path.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            path.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            path.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
