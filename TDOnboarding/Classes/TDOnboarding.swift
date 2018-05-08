//
//  TDOnboarding.swift
//  TDOnboarding
//
//  Created by Anh Phan Tran on 04/05/2018.
//

import Foundation
import UIKit

public class TDOnboarding {
    var items: [TDOnboardingItem]
    var options: TDOnboardingOptions

    public init(items: [TDOnboardingItem], options: TDOnboardingOptions) {
        self.items = items
        self.options = options
    }

    public func present(from presentingViewController: UIViewController, animated: Bool = true, completion: (() -> Void)?) {
        guard let onboardingVC = TDOnboardingViewController.initiateFromStoryboard(with: self.items, options: self.options) else {
            return
        }
        presentingViewController.present(onboardingVC, animated: animated, completion: completion)
    }
}
