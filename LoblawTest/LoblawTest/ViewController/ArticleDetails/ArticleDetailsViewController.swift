//
//  ArticleDetailsViewController.swift
//  LoblawTest
//
//  Created by Kalpesh Thakare on 2020-08-31.
//  Copyright © 2020 Kalpesh Thakare. All rights reserved.
//

import UIKit

class ArticleDetailsViewController: UIViewController {



    //MARK: VARIABLES

    var details = ArticleDetails()

    //MARK: IBOUTLETS

    @IBOutlet weak var lbl_ArticleTitle: UILabel!
    @IBOutlet weak var imgView_Image: UIImageView!
    @IBOutlet weak var lbl_DescriptionTitle: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!

    @IBOutlet weak var height_ImageView: NSLayoutConstraint!

    //MARK:VIEW METHODS

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {

        self.lbl_ArticleTitle.text = details.title ?? ""

        if let imageURL:String = details.thumbnail, (details.thumbnail?.hasPrefix("http"))!{
            self.imgView_Image.sd_setImage(with: URL(string: imageURL)) { (downloadedImage, error, cache, url) in
                DispatchQueue.main.async {
                    self.imgView_Image.image = downloadedImage
                    let aspectRatio = (downloadedImage! as UIImage).size.height/(downloadedImage! as UIImage).size.width
                    let imageHeight = self.view.frame.width*aspectRatio
                    UIView.performWithoutAnimation {
                        self.height_ImageView.constant = imageHeight
                    }
                }
            }
        } else {
            self.height_ImageView.constant = 0
        }

        if details.selftext == "" || details.selftext == nil {
            self.lbl_DescriptionTitle.isHidden = true
            self.lbl_Description.isHidden = true
        } else {
            self.lbl_DescriptionTitle.isHidden = false
            self.lbl_Description.isHidden = false
            self.lbl_Description.text = details.selftext!

        }
    }

    //MARK:IBACTIONS


    @IBAction func OnClick_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }


}

