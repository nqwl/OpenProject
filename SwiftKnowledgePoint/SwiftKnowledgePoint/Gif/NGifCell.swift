//
//  NGifCell.swift
//  SwiftKnowledgePoint
//
//  Created by 陈辉 on 2020/1/8.
//  Copyright © 2020 Nqwl. All rights reserved.
//

import UIKit

class NGifCell: UITableViewCell {
    var gifImageView : UIImageView = UIImageView.init(frame: CGRect.zero)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.gifImageView)
        self.gifImageView.backgroundColor = UIColor.randomColor()
        self.gifImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
