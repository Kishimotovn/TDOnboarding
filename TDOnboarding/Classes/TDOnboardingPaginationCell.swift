//
//  TDOnboardingPaginationCell.swift
//  TDOnboarding
//
//  Created by Anh Phan Tran on 04/05/2018.
//

import Foundation
import UIKit

public protocol TDOnboardingPaginationCell {
    static var identifier: String { get }
    static var nib: UINib { get }
    func configure(for index: Int, isSelected: Bool, options: TDOnboardingOptions?)
}
