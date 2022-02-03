//
//  GProofMockRouter.swift
//
//  © Copyright IBM Deutschland GmbH 2021
//  SPDX-License-Identifier: Apache-2.0
//

@testable import CovPassCheckApp
import CovPassCommon
import CovPassUI
import PromiseKit

class GProofMockRouter: GProofRouterProtocol {

    var errorShown = false
    var certificateShown = false
    var showDifferentPersonShown = false
    var sceneCoordinator: SceneCoordinator = SceneCoordinatorMock()

    func scanQRCode() -> Promise<ScanResult> {
        .value(.success(""))
    }
    
    func showCertificate(_ certificate: CBORWebToken?, _2GContext: Bool, userDefaults: Persistence) {
        certificateShown = true
    }
    
    func showError(error: Error) {
        errorShown = true
    }
    
    func showDifferentPerson(gProofToken: CBORWebToken, testProofToken: CBORWebToken) -> Promise<GProofResult> {
        showDifferentPersonShown = true
        return .value(.cancel)
    }
    
    func showStart() {
        
    }
}