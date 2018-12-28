//
//  MovieCollectionViewCell.swift
//  MovieBrowser
//
//  Created by Shayona on 28/12/18.
//  Copyright © 2018 Shayona. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var movieImgVw: UIImageView!
    
    @IBOutlet weak var movieTitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clear
        
        movieTitleLbl.lineBreakMode = .byWordWrapping
        movieTitleLbl.textAlignment = .center
        movieTitleLbl.numberOfLines = 3
        movieTitleLbl.font = UIFont.appFont(withsize: AppConstant.PADDING * 1.4)
        movieTitleLbl.textColor = UIColor.white
    }
}
