//
//  TopicsTableCell.swift
//  Cards
//
//  Created by Viacheslav on 08.07.2024.
//

import Foundation
import UIKit

class TopicsTableCell: UITableViewCell {
    
    var flashCardTopic: FlashCardTopic?
    
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    private func setupCell() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.font = UIFont.systemFont(ofSize: 40)
        contentView.addSubview(label)
        
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            label.topAnchor.constraint(equalTo: contentView.topAnchor),
//            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}
