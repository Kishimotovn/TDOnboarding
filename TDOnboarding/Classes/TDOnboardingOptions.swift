//
//  TDOnboardingOptions.swift
//  TDOnboarding
//
//  Created by Anh Phan Tran on 04/05/2018.
//

import Foundation

public enum TDOnboardingMeasurableComponent {
    case bottomPanelHeight
    case imageTopDistance
    case imageBottomDistance
    case bottomActionButtonWidth
}

public enum TDOnboardingColorizableComponent {
    case paginationItem
    case backgroundImageOverlay
    case bottomPanel
}

public enum TDOnboardingConfigurableComponent {
    case topActionButton(UIButton)
    case bottomActionButton(UIButton)
}

public protocol TDOnboardingOptions {
    var defaultBackgroundImage: UIImage { get }
    var tintColor: UIColor { get }
    var statusBarStyle: UIStatusBarStyle { get }
    var paginationCell: TDOnboardingPaginationCell.Type { get }
    func measure(for component: TDOnboardingMeasurableComponent) -> CGFloat?
    func configure(for component: TDOnboardingConfigurableComponent)
    func color(for component: TDOnboardingColorizableComponent) -> UIColor?
}

public extension TDOnboardingOptions {
    func measure(for component: TDOnboardingMeasurableComponent) -> CGFloat? {
        return nil
    }

    func configure(for component: TDOnboardingConfigurableComponent) {
        switch component {
        case .bottomActionButton(let button):
            button.backgroundColor = UIColor.black
            button.layer.cornerRadius = 5.0
            button.layer.masksToBounds = true
        default:
            break
        }
    }

    func color(for component: TDOnboardingColorizableComponent) -> UIColor? {
        return nil
    }

    var paginationCell: TDOnboardingPaginationCell.Type {
        return TDOnboardingPaginationDefaultCell.self
    }
}
