//
//  TDOnboardingPaginationView.swift
//  TDOnboarding
//
//  Created by Anh Phan Tran on 04/05/2018.
//

import Foundation
import UIKit

class TDOnboardingPaginationView: UIView {
    // MARK: - IBOutlets:
    @IBOutlet weak var paginationCollectionView: UICollectionView!
    
    // MARK: - Model:
    var currentItem: Int = 0
    var itemCount: Int = 0 {
        didSet {
            self.configure()
        }
    }
    var cell: TDOnboardingPaginationCell.Type = TDOnboardingPaginationDefaultCell.self {
        didSet {
            self.paginationCollectionView.register(cell.nib, forCellWithReuseIdentifier: cell.identifier)
        }
    }
    var options: TDOnboardingOptions? {
        didSet {
            self.cell = options?.paginationCell ?? TDOnboardingPaginationDefaultCell.self
            self.configure()
        }
    }

    // MARK: - View Life Cycle:
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cell = TDOnboardingPaginationDefaultCell.self
        self.paginationCollectionView.allowsMultipleSelection = false
        self.paginationCollectionView.dataSource = self
        self.paginationCollectionView.delegate = self
        self.paginationCollectionView.contentInset = UIEdgeInsets.zero
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.paginationCollectionView.reloadData()
    }
    
    // MARK: - Funcs:
    func configure() {
        self.paginationCollectionView.reloadData()
        if self.itemCount > 0 {
            self.paginationCollectionView.selectItem(at: IndexPath.init(row: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        }
    }
    
    func changeCurrentItem(to newIndex: Int) {
        self.currentItem = newIndex
        self.paginationCollectionView.reloadData()
    }
}

extension TDOnboardingPaginationView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.itemCount == 0 ? 0 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cell.identifier, for: indexPath) as! TDOnboardingPaginationCell
        cell.configure(for: indexPath.row, isSelected: self.currentItem == indexPath.row, options: self.options)
        return cell as! UICollectionViewCell
    }
}

extension TDOnboardingPaginationView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 10, height: 10.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let totalCellWidth = CGFloat(self.itemCount) * 10.0 + CGFloat(self.itemCount - 1)*20.0
        let padding = ((collectionView.frame.width - totalCellWidth) / 2)
        return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
