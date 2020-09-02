//
//  ArticleCell.swift
//  LoblawTest
//
//  Created by Kalpesh Thakare on 2020-08-31.
//  Copyright © 2020 Kalpesh Thakare. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {


    @IBOutlet weak var lbl_ArticleTitle: UILabel!
    @IBOutlet weak var imgView_ArticleImage: UIImageView!
    @IBOutlet weak var view_Background: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.makeRounded(view: view_Background)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        self.imgView_ArticleImage.image = nil
    }

    func makeRounded(view: UIView) {
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.black.cgColor
        view.clipsToBounds = true
        view.layer.cornerRadius = 10.0
        }
}
