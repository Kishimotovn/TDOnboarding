//
//  TDOnboardingItem.swift
//  TDOnboarding
//
//  Created by Anh Phan Tran on 04/05/2018.
//

import Foundation

public protocol TDOnboardingItem {
    var image: UIImage { get }
    var subtitle: NSAttributedString { get }
    var topTitle: NSAttributedString? { get }
    var bottomTitle: NSAttributedString? { get }
    var topActionButtonTitle: NSAttributedString? { get }
    var bottomActionButtonTitle: NSAttributedString? { get }
}
