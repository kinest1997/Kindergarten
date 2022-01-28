//
//  CocktailCell.swift
//  CocktailDB
//
//  Created by 강희성 on 2022/01/11.
//

import Foundation
import SnapKit
import UIKit

class CocktailCell: UITableViewCell {
    
    let mainTextLabel = UILabel()
    let mainImageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(mainTextLabel)
        contentView.addSubview(mainImageView)
        contentView.backgroundColor = .green
        
        mainImageView.contentMode = .scaleAspectFit
        mainImageView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(mainImageView.snp.height)
        }
        mainTextLabel.snp.makeConstraints {
            $0.leading.equalTo(mainImageView.snp.trailing)
            $0.centerY.equalTo(mainImageView)
        }
    }
}
