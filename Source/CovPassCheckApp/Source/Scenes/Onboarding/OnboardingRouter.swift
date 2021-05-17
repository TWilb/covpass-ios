//
//  OnboardingRouter.swift
//
//
//  © Copyright IBM Deutschland GmbH 2021
//  SPDX-License-Identifier: Apache-2.0
//

import Foundation
import UIKit
import CovPassCommon
import CovPassUI

struct OnboardingRouter: OnboardingRouterProtocol {
    // MARK: - Properties

    let sceneCoordinator: SceneCoordinator

    // MARK: - Lifecycle

    init(sceneCoordinator: SceneCoordinator) {
        self.sceneCoordinator = sceneCoordinator
    }

    // MARK: - Methods

    func showNextScene() {
        sceneCoordinator.asRoot(
            ValidatorOverviewSceneFactory(
                router: ValidatorOverviewRouter(sceneCoordinator: sceneCoordinator)
            )
        )
    }

    func showPreviousScene() {
        sceneCoordinator.asRoot(
            WelcomeSceneFactory(
                router: WelcomeRouter(sceneCoordinator: sceneCoordinator)
            )
        )
    }
}