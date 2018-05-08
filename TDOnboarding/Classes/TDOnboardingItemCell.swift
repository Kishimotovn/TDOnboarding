//
//  TDOnboardingItemCell.swift
//  Pods-TDOnboarding_Example
//
//  Created by Anh Phan Tran on 04/05/2018.
//

import UIKit

class TDOnboardingItemCell: UICollectionViewCell {
    // MARK: - IBOutlets:
    @IBOutlet weak var topTitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomTitleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var bottomSkipButton: UIButton!
    @IBOutlet weak var bottomPanelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageTopDistanceConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageBottomDistanceConstraint: NSLayoutConstraint!

    // MARK: - Model:
    var item: TDOnboardingItem!
    var options: TDOnboardingOptions!

    // MARK: - Funcs:
    func configure() {
        self.imageView.image = self.item.image
        self.bottomTitleLabel.attributedText = self.item.bottomTitle
        self.subtitleLabel.attributedText = self.item.subtitle
        self.bottomSkipButton.setAttributedTitle(self.item.bottomActionButtonTitle, for: .normal)
        self.bottomSkipButton.isHidden = self.item.bottomActionButtonTitle == nil
        self.bottomTitleLabel.isHidden = self.item.bottomTitle == nil
        self.bottomPanelHeightConstraint.constant = self.options.measure(for: .bottomPanelHeight) ?? 300.0
        self.imageTopDistanceConstraint.constant = self.options.measure(for: .imageTopDistance) ?? 30.0
        self.imageBottomDistanceConstraint.constant = self.options.measure(for: .imageBottomDistance) ?? 30.0
        self.options.configure(for: .bottomActionButton(self.bottomSkipButton))
        self.topTitleLabel.attributedText = self.item.topTitle
        self.topTitleLabel.isHidden = self.item.topTitle == nil
    }
}

