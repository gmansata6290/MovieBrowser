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
    
    var networkManager: NetworkManager? = NetworkManager()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellWidth = ScreenSize.SCREEN_WIDTH / numberOfItemsInRow - (AppConstant.PADDING * 1.5)
        let cellSize = CGSize(width: cellWidth, height: cellWidth * 2)
        
        //Customize layout which is adaptive to all devices.
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.itemSize = cellSize
        layout.headerReferenceSize = CGSize(width: collectionView.frame.width, height: AppConstant.PADDING * 6)
        layout.sectionHeadersPinToVisibleBounds = true
        layout.sectionInset = UIEdgeInsets(top: AppConstant.PADDING, left: AppConstant.PADDING,  bottom: AppConstant.PADDING, right: AppConstant.PADDING)
        layout.minimumLineSpacing = AppConstant.PADDING
        layout.minimumInteritemSpacing = UIDevice.current.iPad ? AppConstant.PADDING / 2 : 0
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        loadMovies()
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView:UICollectionReusableView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader", for: indexPath) as! SearchBarCollectionReusableView
            
            return headerView
        }
        
        return UICollectionReusableView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            as? MovieCollectionViewCell
            else
        {
            return UICollectionViewCell()
        }
        
        // Configure the cell
        cell.movieTitleLbl?.text = movies[indexPath.row].title ?? ""
        
        if let url = movies[indexPath.row].posterPath {
        
            cell.movieImgVw.kf.indicatorType = .activity
            cell.movieImgVw.kf.indicator?.startAnimatingView()

            cell.movieImgVw.kf.setImage(with: ImageResource(downloadURL: URL(string: AppConstant.IMGBASEURL +  url)!), placeholder: nil, options: nil, progressBlock: nil) { (img, error, cache, url) in
                
                cell.movieImgVw.alpha = 0
                
                if let image = img {
                    
                    //Animating fading animation
                    UIView.animate(withDuration: 1, animations: {
                        cell.movieImgVw.alpha = 1
                    })
                    
                    cell.movieImgVw.image = image
                    cell.movieImgVw.contentMode = .scaleAspectFill
                    cell.movieImgVw.kf.indicator?.stopAnimatingView()
                    
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
                }
            }
        }
        
        //Shadowing and Rounded Corners
        cell.contentView.layer.cornerRadius = AppConstant.PADDING / 2
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == movies.count - 1 && page <= totalPageCount {
            
            print("before adding count : \(movies.count)")
            print("loading more....")
            loadMovies(byPage: page)
            
        }
    }
    
    func loadMovies(byPage page : Int = 1) {
        
        networkManager?.getNewMovies(page: page) { [weak self] movieList, error in
            
            guard let strongSelf = self
                else
            {
                return
            }
            
            if let movies = movieList?.movies, error == nil, let totalPageCount = movieList?.numberOfPages
            {
                print("response movies count : \(movies.count)")
                DispatchQueue.main.async { [weak self] in
                    
                    guard let strongSelf = self
                        else
                    {
                        return
                    }
                    
                    strongSelf.totalPageCount = totalPageCount
                    if strongSelf.movies.count == 0 {
                        strongSelf.movies = movies
                    }
                    else {
                        strongSelf.movies.append(contentsOf: movies)
                    }
                    
                    print("after adding movies count : \(strongSelf.movies.count)")
                    
                    strongSelf.page += 1
                    strongSelf.collectionView.reloadData()
                }
            }
        }
    }
}

extension MoviesCollectionViewController : UISearchBarDelegate {
    
}
