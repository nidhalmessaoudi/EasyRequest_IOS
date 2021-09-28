//
//  AnimateUIButton.swift
//  EasyRequest
//
//  Created by Nidhal Messaoudi on 9/28/21.
//  Copyright © 2021 Nidhal Messaoudi. All rights reserved.
//

import UIKit

extension UIButton {
    override open var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.25, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                self.alpha = self.isHighlighted ? 0.5 : 1
            }, completion: nil)
        }
    }
}
