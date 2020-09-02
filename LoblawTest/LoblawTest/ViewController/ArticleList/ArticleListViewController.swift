//
//  ArticleListViewController.swift
//  LoblawTest
//
//  Created by Kalpesh Thakare on 2020-08-31.
//  Copyright © 2020 Kalpesh Thakare. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleListViewController: UIViewController {



    //MARK: VARIABLES

    var articlesList = [Articles]()
    var rowHeights:[Int:CGFloat] = [:] //declaration of Dictionary


    //MARK: IBOUTLETS

    @IBOutlet weak var tblView_ArticleList: UITableView!


    //MARK:VIEW METHODS

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.tblView_ArticleList.delegate = self
        self.tblView_ArticleList.dataSource = self

        tblView_ArticleList.tableFooterView = UIView()
        tblView_ArticleList.estimatedRowHeight = 100
        tblView_ArticleList.rowHeight = UITableView.automaticDimension

        DispatchQueue.main.async {
            self.Webservice_GetArticles()
        }
    }

}

extension ArticleListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesList.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let articleCell = self.tblView_ArticleList.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath)as! ArticleCell

        let articleDetails:Articles = self.articlesList[indexPath.row]

        articleCell.lbl_ArticleTitle.text = articleDetails.data.title
        if let imageURL:String = articleDetails.data.thumbnail, (articleDetails.data.thumbnail?.hasPrefix("http"))!{
            self.setImageFromUrl(url: imageURL, to: articleCell.imgView_ArticleImage, indexPath: indexPath)
        }
        return articleCell
    }

    //My heightForRowAtIndexPath method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = self.rowHeights[indexPath.row]{
            return height
        }else{
            return tableView.rowHeight
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if #available(iOS 13.0, *) {
            let articleDetailsVC = storyBoard.instantiateViewController(identifier: "ArticleDetailsViewController")as ArticleDetailsViewController
            articleDetailsVC.details = self.articlesList[indexPath.row].data
            self.navigationController?.pushViewController(articleDetailsVC, animated: true)
        } else {
            let vc = storyBoard.instantiateViewController(withIdentifier: "ArticleDetailsViewController") as! ArticleDetailsViewController
            vc.details = self.articlesList[indexPath.row].data
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ArticleListViewController {

    func Webservice_GetArticles() {
        NetworkHelper.sharedInstance.getDataFromUrl(url: "https://www.reddit.com/r/swift/.json", SuccessBlock: { (data) in
            do{
                let articleList:ArticleModel = try JSONDecoder().decode(ArticleModel.self, from: data)
                self.articlesList = articleList.data.children
                DispatchQueue.main.async {
                    self.tblView_ArticleList.reloadData()
                }
            }
            catch {
                NSLog("json error: \(error)")
            }

        }) { (failureMessage) in
            let alert = UIAlertController(title: "Message", message: " Error \(String(describing: failureMessage))", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func setImageFromUrl(url:String, to ImageView:UIImageView, indexPath: IndexPath) {

            ImageView.sd_setImage(with: URL(string: url)) { (downloadedImage, error, cache, url) in
                DispatchQueue.main.async {
                    if downloadedImage != nil {
                    let aspectRatio = (downloadedImage! as UIImage).size.height/(downloadedImage! as UIImage).size.width
                    ImageView.image = downloadedImage
                    let imageHeight = self.view.frame.width*aspectRatio

                    UIView.performWithoutAnimation {
                        self.tblView_ArticleList.beginUpdates()
                        self.rowHeights[indexPath.row] = imageHeight
                        self.tblView_ArticleList.endUpdates()
                    }
                    } else {
                        print(error!)
                    }
                }
            }
    }
}
