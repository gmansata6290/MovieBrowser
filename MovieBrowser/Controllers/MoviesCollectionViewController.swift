//
//  MoviesCollectionViewController.swift
//  MovieBrowser
//
//  Created by Shayona on 28/12/18.
//  Copyright © 2018 Shayona. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesCollectionViewController: UICollectionViewController {

    private let reuseIdentifier = "movieCell"
    private let numberOfItemsInRow : CGFloat = UIDevice.current.iPad ? 3 : 2
    var movies : [Movie] = []
    var page = 1
    var totalPageCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellWidth = ScreenSize.SCREEN_WIDTH / numberOfItemsInRow - (AppConstant.PADDING * 1.5)
        let cellSize = CGSize(width: cellWidth, height: cellWidth * 2)
        
        //Customize layout which is adaptive to all devices.
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: AppConstant.PADDING, left: AppConstant.PADDING,  bottom: AppConstant.PADDING, right: AppConstant.PADDING)
        layout.minimumLineSpacing = AppConstant.PADDING
        layout.minimumInteritemSpacing = UIDevice.current.iPad ? AppConstant.PADDING / 2 : 0
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            as? MovieCollectionViewCell
            else
        {
            return UICollectionViewCell()
        }
        
        // Configure the cell
        cell.movieTitleLbl?.text = movies[indexPath.row].title
        cell.movieImgVw.kf.indicatorType = .activity
        cell.movieImgVw.kf.indicator?.startAnimatingView()
        cell.backgroundColor = UIColor.red
        
        //Shadowing and Rounded Corners
        cell.contentView.layer.cornerRadius = AppConstant.PADDING / 2
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: AppConstant.PADDING)
        cell.layer.shadowRadius = AppConstant.PADDING / 2
        cell.layer.shadowOpacity = 0.4
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        cell.layer.backgroundColor = UIColor.clear.cgColor

        //Shadowing performance can be reduced by below 2 lines. So that lag will be reduced while scrolling the cells
        cell.layer.rasterizationScale = UIScreen.main.scale
        cell.layer.shouldRasterize = true
        
        return cell
    }
}
