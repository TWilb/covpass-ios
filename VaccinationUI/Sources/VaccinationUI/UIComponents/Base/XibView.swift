//
//  XibView.swift
//
//
//  This is the base view class for all UI components that
//  allows us to display modules directly in the InterfaceBuilder.
//
//  All constraints within a XibView need to have a priority lower
//  than 1000 to prevent conflicts when hiding the view.
//
//  Copyright © 2018 IBM. All rights reserved.
//

import UIKit

@IBDesignable
open class XibView: UIView, Compoundable {
    public weak var compoundDelegate: CompoundableUpdate?

    // content view from the xib file
    public var contentView: UIView?

    // name of the xib file
    @objc dynamic var nibName: String? {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last
    }

    open override var bounds: CGRect {
        didSet {
            compoundDelegate?.compoundableDidUpdate()
        }
    }

    // MARK: - Lifecycle

    open func initView() {
        // Do some additional initializing
        //
        // The IB doesn't call the awakeFromNib which is why
        // we need to call it in prepareForInterfaceBuilder as well.
    }

    open override func awakeFromNib() {
        super.awakeFromNib()

        initView()
    }

    public convenience init() {
        self.init(frame: CGRect.zero)

        initView()
    }

    public required override init(frame: CGRect) {
        super.init(frame: frame)

        xibSetup()
        initView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        xibSetup()
    }

    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        initView()
        contentView?.prepareForInterfaceBuilder()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        compoundDelegate?.compoundableDidUpdate()
    }

    // MARK: - Private Helpers

    private func xibSetup() {
        // load view from xib file and
        // add as subview with autoresizing mask for autolayout constraints
        // ATTENTION: don't call this method twice in a view lifecycle
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }

    private func loadViewFromNib() -> UIView? {
        // try to instantiate an UIView
        guard let nibName = nibName else { return nil }
        let bundle = Bundle.module
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
