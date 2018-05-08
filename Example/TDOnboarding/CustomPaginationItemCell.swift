//
//  CustomPaginationItemCell.swift
//  TDOnboarding_Example
//
//  Created by Anh Phan Tran on 04/05/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import TDOnboarding

class CustomPaginationItemCell: UICollectionViewCell {
    // MARK: - IBOutlets:
    @IBOutlet weak var dotView: UIView!
}

extension CustomPaginationItemCell: TDOnboardingPaginationCell {
    static var identifier: String = "CustomPaginationItemCell"
    
    static var nib: UINib = UINib(nibName: "CustomPaginationItemCell", bundle: nil)
    
    func configure(for index: Int, isSelected: Bool, options: TDOnboardingOptions?) {
        self.dotView.backgroundColor = isSelected ? (options?.color(for: .paginationItem) ?? UIColor.blue) : UIColor.green
    }
}
