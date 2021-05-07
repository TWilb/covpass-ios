//
//  CheckboxView.swift
//  
//
//  Copyright © 2021 IBM. All rights reserved.
//

import UIKit

public class CheckboxView: XibView {
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var checkbox: UIButton!
    @IBOutlet var textView: UITextView!

    var checked: Bool = false
    var didChangeState: ((Bool) -> Void)?

    public override func initView() {
        super.initView()

        stackView.spacing = .space_12
        checkbox.setBackgroundImage(.checkboxUnchecked, for: .normal)
        checkbox.setBackgroundImage(.checkboxChecked, for: .selected)
        textView.isScrollEnabled = false
        updateCheckbox()
    }

    @IBAction func checkboxPressed() {
        checked.toggle()
        updateCheckbox()
        didChangeState?(checked)
    }

    private func updateCheckbox() {
        checkbox.isSelected = checked
        checkbox.tintColor = checked ? UIColor.onBackground50 : UIColor.onBrandAccent
    }
}