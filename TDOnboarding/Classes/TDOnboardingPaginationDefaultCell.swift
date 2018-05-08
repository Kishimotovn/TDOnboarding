//
//  TDOnboardingPaginationDefaultCell.swift
//  TDOnboarding
//
//  Created by Anh Phan Tran on 04/05/2018.
//

import Foundation
import UIKit

class TDOnboardingPaginationDefaultCell: UICollectionViewCell {
    // MARK: - IBOutlets:
    @IBOutlet weak var dotView: UIView!

    // MARK: - View Life Cycle:
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dotView.layer.cornerRadius = 5.0
        self.dotView.layer.masksToBounds = true
    }
}

extension TDOnboardingPaginationDefaultCell: TDOnboardingPaginationCell {
    static var identifier: String = "tdOnboardingPaginationDefaulCell"

    static var nib: UINib = UINib(nibName: "TDOnboardingPaginationDefaultCell", bundle: Bundle(for: TDOnboardingPaginationDefaultCell.classForCoder()))
    
    func configure(for index: Int, isSelected: Bool, options: TDOnboardingOptions?) {
        self.dotView.backgroundColor = isSelected ? (options?.color(for: .paginationItem) ?? UIColor.white) : UIColor.clear
        self.dotView.layer.borderWidth = isSelected ? 0.0 : 1.0
        self.dotView.layer.borderColor = isSelected ? UIColor.clear.cgColor : (options?.color(for: .paginationItem)?.cgColor ?? UIColor.white.cgColor)
    }
}
