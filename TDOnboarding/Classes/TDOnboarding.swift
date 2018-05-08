//
//  TDOnboarding.swift
//  TDOnboarding
//
//  Created by Anh Phan Tran on 04/05/2018.
//

import Foundation
import UIKit

public protocol TDOnboardingDelegate: class {
    func topActionButtonTapped(on onboarding: TDOnboarding, itemIndex: Int)
    func bottomActionButtonTapped(on onboarding: TDOnboarding, itemIndex: Int)
}

public class TDOnboarding {
    var items: [TDOnboardingItem]
    var options: TDOnboardingOptions

    public weak var delegate: TDOnboardingDelegate?

    public init(items: [TDOnboardingItem], options: TDOnboardingOptions) {
        self.items = items
        self.options = options
    }

    public func present(from presentingViewController: UIViewController, animated: Bool = true, completion: (() -> Void)?) {
        guard let onboardingVC = TDOnboardingViewController.initiateFromStoryboard(with: self) else {
            return
        }
        presentingViewController.present(onboardingVC, animated: animated, completion: completion)
    }
}
