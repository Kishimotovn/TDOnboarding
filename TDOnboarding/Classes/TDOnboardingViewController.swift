//
//  TDOnboardingViewController.swift
//  TDOnboarding
//
//  Created by Anh Phan Tran on 04/05/2018.
//

import UIKit

class TDOnboardingViewController: UIViewController {
  class public func initiateFromStoryboard(with onboarding: TDOnboarding) -> TDOnboardingViewController? {
    let storyboard = UIStoryboard(name: "TDOnboarding", bundle: Bundle(for: TDOnboardingViewController.classForCoder()))
    if let vc = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? TDOnboardingViewController {
      vc.onboarding = onboarding
      return vc
    }
    
    return nil
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return self.options.statusBarStyle
  }
  
  // MARK: - IBOutlets:
  @IBOutlet weak var onboardingCollectionView: UICollectionView!
  @IBOutlet weak var defaultBackgroundImageView: UIImageView!
  @IBOutlet weak var bottomPanelView: UIView!
  @IBOutlet weak var bottomPanelHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var topActionButton: UIButton!
  @IBOutlet weak var paginationView: TDOnboardingPaginationView!
  @IBOutlet weak var backgroundImageOverlayView: UIView!
  @IBOutlet weak var bottomPanelTail: UIView!
  
  
  // MARK: - IBActions:
  @IBAction func topActionButtonTapped() {
    self.delegate?.topActionButtonTapped(on: self.onboarding, itemIndex: self.currentPage)
  }
  
  // MARK: - Model:
  var onboarding: TDOnboarding!
  var items: [TDOnboardingItem] {
    return self.onboarding.items
  }
  var options: TDOnboardingOptions {
    return self.onboarding.options
  }
  var delegate: TDOnboardingDelegate? {
    return self.onboarding.delegate
  }
  
  var currentPage: Int = 0 {
    didSet {
      self.topActionButton.isHidden = self.items[currentPage].topActionButtonTitle == nil
      self.topActionButton.setAttributedTitle(self.items[currentPage].topActionButtonTitle, for: .normal)
      self.paginationView.changeCurrentItem(to: currentPage)
    }
  }
  
  // MARK: - View Life Cycle:
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupUI()
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    
    self.onboardingCollectionView.collectionViewLayout.invalidateLayout()
    guard self.currentPage < self.items.count else {
      return
    }
    
    self.onboardingCollectionView.scrollToItem(at: IndexPath(item: self.currentPage, section: 0), at: .centeredHorizontally, animated: false)
  }
  // MARK: - Funcs:
  func setupUI() {
    self.onboardingCollectionView.dataSource = self
    self.onboardingCollectionView.delegate = self
    self.onboardingCollectionView.isPagingEnabled = true
    self.defaultBackgroundImageView.image = self.options.defaultBackgroundImage
    self.bottomPanelHeightConstraint.constant = self.options.measure(for: .bottomPanelHeight) ?? 300.0
    self.paginationView.options = self.options
    self.paginationView.itemCount = self.items.count
    self.currentPage = 0
    self.bottomPanelView.backgroundColor = self.options.color(for: .bottomPanel) ?? UIColor(red: 80/255, green: 227/255, blue: 194/255, alpha: 1.0)
    self.bottomPanelTail.backgroundColor = self.options.color(for: .bottomPanel) ?? UIColor(red: 80/255, green: 227/255, blue: 194/255, alpha: 1.0)
    self.backgroundImageOverlayView.backgroundColor = self.options.color(for: .backgroundImageOverlay) ?? UIColor.black.withAlphaComponent(0.3)
    self.options.configure(for: .backgroundImageView(self.defaultBackgroundImageView))
  }
}

extension TDOnboardingViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return self.items.count == 0 ? 0 : 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.items.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingItemCell", for: indexPath) as! TDOnboardingItemCell
    cell.item = self.items[indexPath.row]
    cell.options = self.options
    cell.delegate = self
    cell.configure()
    return cell
  }
}

extension TDOnboardingViewController: TDOnboardingItemCellDelegate {
  func bottomActionTapped(on cell: TDOnboardingItemCell) {
    self.delegate?.bottomActionButtonTapped(on: self.onboarding, itemIndex: self.currentPage)
  }
}

extension TDOnboardingViewController: UICollectionViewDelegate {
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let x = onboardingCollectionView.contentOffset.x
    let w = onboardingCollectionView.bounds.size.width
    var currentPage = Int(ceil(x/w))
    if currentPage >= self.items.count {
      currentPage = self.items.count - 1
    }
    self.currentPage = currentPage
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    self.topActionButton.isHidden = true
  }
}

extension TDOnboardingViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if #available(iOS 11.0, *) {
      return self.view.safeAreaLayoutGuide.layoutFrame.size
    } else {
      return self.view.bounds.size
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0.0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0.0
  }
}
