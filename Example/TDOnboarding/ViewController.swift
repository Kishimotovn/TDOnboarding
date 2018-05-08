//
//  ViewController.swift
//  TDOnboarding
//
//  Created by Anh Phan Tran on 05/04/2018.
//  Copyright (c) 2018 Anh Phan Tran. All rights reserved.
//

import UIKit
import TDOnboarding

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        var items = [ExampleOnboardingItem]()
        items.append(ExampleOnboardingItem(image: #imageLiteral(resourceName: "iphoneplaceholder"), title: "Item 1", subtitle: "remaining essentially unchanged. It was popularised in the 1960s", isLast: false))
        items.append(ExampleOnboardingItem(image: #imageLiteral(resourceName: "iphoneplaceholder"), title: "Item 2", subtitle: "It has survived not only five centuries, but also the leap into electronic typesetting", isLast: false))
        items.append(ExampleOnboardingItem(image: #imageLiteral(resourceName: "iphoneplaceholder"), title: "Item 3", subtitle: "when an unknown printer took a galley of type and scrambled it to make a type specimen book", isLast: false))
        items.append(ExampleOnboardingItem(image: #imageLiteral(resourceName: "iphoneplaceholder"), title: "Item 4", subtitle: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,", isLast: true))
        let onboarding = TDOnboarding(items: items, options: ExampleOnboardingOptions())
        onboarding.present(from: self, completion: nil)
    }
}

struct ExampleOnboardingItem: TDOnboardingItem {
    var image: UIImage
    var subtitle: NSAttributedString
    var topTitle: NSAttributedString?
    var bottomTitle: NSAttributedString?
    var topActionButtonTitle: NSAttributedString?
    var bottomActionButtonTitle: NSAttributedString?

    init(image: UIImage, title: String, subtitle: String, isLast: Bool) {
        let titleAttributes: [NSAttributedStringKey: Any] = [
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold),
            .foregroundColor: UIColor.white
        ]

        let subtitleAttributes: [NSAttributedStringKey: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .light),
            .foregroundColor: UIColor.white
        ]

        self.image = image
        self.subtitle = NSAttributedString(string: subtitle, attributes: subtitleAttributes)
        self.topTitle = NSAttributedString(string: title, attributes: titleAttributes)
        self.bottomTitle = NSAttributedString(string: title, attributes: titleAttributes)
        self.topActionButtonTitle = NSAttributedString(string: "Skip", attributes: subtitleAttributes)
//        self.bottomActionButtonTitle = isLast ? NSAttributedString(string: "Complete", attributes: titleAttributes) : nil
    }
}

struct ExampleOnboardingOptions: TDOnboardingOptions {
    var statusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    var tintColor: UIColor {
        return UIColor.white
    }
    
    var defaultBackgroundImage: UIImage {
        return #imageLiteral(resourceName: "disruptor4K")
    }

    func measure(for component: TDOnboardingMeasurableComponent) -> CGFloat? {
        switch component {
        case .bottomPanelHeight:
            return 170.0
        case .imageBottomDistance, .imageTopDistance:
            return 0.0
        case .bottomActionButtonWidth:
            return 315.0
        }
    }

    func configure(for component: TDOnboardingConfigurableComponent) {
        switch component {
        case .bottomActionButton(let button):
            button.layer.cornerRadius = 5.0
            button.layer.masksToBounds = true
            button.backgroundColor = UIColor.black
        default:
            break
        }
    }

    var paginationCell: TDOnboardingPaginationCell.Type {
        return CustomPaginationItemCell.self
    }
}

