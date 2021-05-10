//
//  StartOnboardingViewModel.swift
//
//
//  Copyright © 2021 IBM. All rights reserved.
//

import UIKit
import VaccinationUI

class StartOnboardingViewModel: BaseViewModel {
    // MARK: - Properties

    weak var delegate: ViewModelDelegate?
    let router: StartRouterProtocol

    var image: UIImage? {
        .illustration1
    }

    var title: String {
        "start_onboarding_title".localized
    }

    var info: String {
        "start_onboarding_message".localized
    }

    var secureTitle: String {
        "start_onboarding_secure_title".localized
    }

    var secureText: String {
        "start_onboarding_secure_message".localized
    }

    var navigationButtonTitle: String {
        "start_onboarding_button_title".localized
    }

    // MARK: - Lifecycle

    init(router: StartRouterProtocol) {
        self.router = router
    }

    // MARK: - Methods

    func showNextScene() {
        router.showNextScene()
    }
}
