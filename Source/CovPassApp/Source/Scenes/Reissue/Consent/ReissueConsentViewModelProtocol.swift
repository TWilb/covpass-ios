import CovPassUI
import CovPassCommon
import Foundation
import UIKit

protocol ReissueConsentViewModelProtocol {
    var delegate: ViewModelDelegate? { get set }
    var certItems: [CertificateItem] { get }
    var titleText: String { get }
    var subTitleText: String { get }
    var descriptionText: String { get }
    var privacyHeadlineText: String { get }
    var hintTitle: String { get }
    var hintText: NSAttributedString { get }
    var dataPrivacyText: String { get }
    var dataPrivacyChecvron: UIImage { get }
    var buttonAgreeTitle: String { get }
    var buttonDisagreeTitle: String { get }
    var isLoading: Bool { get }
    func processAgree()
    func processDisagree()
    func processPrivacyStatement()
}
