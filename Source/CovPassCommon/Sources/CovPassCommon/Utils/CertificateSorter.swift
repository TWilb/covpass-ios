//
//  CertificateSorter.swift
//
//
//  © Copyright IBM Deutschland GmbH 2021
//  SPDX-License-Identifier: Apache-2.0
//

import Foundation

public enum CertificateSorter {
    /// Sorts the certificates by given order
    public static func sort(_ certificates: [ExtendedCBORWebToken]) -> [ExtendedCBORWebToken] {
        var res = [ExtendedCBORWebToken]()
        // #1 Test certificate
        //  Negative PCR Test not older than (=<)72h, ordered by date (newest first)
        let pcrTests = certificates.filter {
            if let t = $0.vaccinationCertificate.hcert.dgc.t?.first, t.isPCR, !t.isPositive, Date() <= Calendar.current.date(byAdding: .hour, value: 72, to: t.sc) ?? Date() {
                return true
            }
            return false
        }
        res.append(contentsOf: pcrTests.sorted(by: {
            guard
                let lhs = $0.vaccinationCertificate.hcert.dgc.t?.first?.sc,
                let rhs = $1.vaccinationCertificate.hcert.dgc.t?.first?.sc
            else {
                return false
            }
            return lhs > rhs
        }))
        // #2 Test certificate
        //  Negative quick test, not older than 48 hrs, ordered by date (newest first)
        let quickTests = certificates.filter {
            if let t = $0.vaccinationCertificate.hcert.dgc.t?.first, !t.isPCR, !t.isPositive, Date() <= Calendar.current.date(byAdding: .hour, value: 48, to: t.sc) ?? Date() {
                return true
            }
            return false
        }
        res.append(contentsOf: quickTests.sorted(by: {
            guard
                let lhs = $0.vaccinationCertificate.hcert.dgc.t?.first?.sc,
                let rhs = $1.vaccinationCertificate.hcert.dgc.t?.first?.sc
            else {
                return false
            }
            return lhs > rhs
        }))
        // #3 Booster Certificate
        //  Latest booster vaccination of a vaccination series (3/3, 4/4, ...)
        res.append(contentsOf: certificates.filter({
            if let v = $0.vaccinationCertificate.hcert.dgc.v?.first, v.isBoosted {
                return true
            }
            return false
        }))
        // #4 Vaccination certificate
        //  Latest vaccination of a vaccination series (1/1, 2/2), older then (>) 14 days
        let vaccinationCertificates = certificates.filter { $0.vaccinationCertificate.hcert.dgc.v != nil }.sorted(by: { c1, c2 -> Bool in c1.vaccinationCertificate.hcert.dgc.v?.first?.dt ?? Date() > c2.vaccinationCertificate.hcert.dgc.v?.first?.dt ?? Date() })
        if let latestVaccination = vaccinationCertificates.first(where: {
            if let v = $0.vaccinationCertificate.hcert.dgc.v?.first, v.fullImmunization, v.fullImmunizationValid, !v.isBoosted /* Boosters are currently lower prioritized (see 5.1) */ {
                return true
            }
            return false
        }) {
            res.append(latestVaccination)
        }
        // #5 Recovery certificate
        //  Recovery after SARS-Cov-2-Infection, not older then (=<) 180 Days
        res.append(contentsOf: certificates.filter {
            if let r = $0.vaccinationCertificate.hcert.dgc.r?.first, Date() <= r.du {
                return true
            }
            return false
        })
        // #6 Vaccination Certificate
        //  Latest vaccination of a vaccination series, not older then (=<) 14 days
        if let latestVaccination = vaccinationCertificates.first(where: {
            if let v = $0.vaccinationCertificate.hcert.dgc.v?.first, v.fullImmunization, !v.fullImmunizationValid {
                return true
            }
            return false
        }) {
            res.append(latestVaccination)
        }
        // #7 Vaccination Certificate
        //  Not-latest (partial immunization) of a vaccination series (1/2)
        res.append(contentsOf: certificates.filter {
            if let v = $0.vaccinationCertificate.hcert.dgc.v?.first, !v.fullImmunization {
                return true
            }
            return false
        })
        // #8 Recovery Certificate
        //  Recovery after SARS-Cov-2-Infection, older then (>) 180 Days
        res.append(contentsOf: certificates.filter {
            if let r = $0.vaccinationCertificate.hcert.dgc.r?.first, Date() > r.du {
                return true
            }
            return false
        })
        // #9 Test certificate
        //  Negative PCR-Test, older then (>) 72 Hrs, or negative quick test older then (>) 48 Hrs
        res.append(contentsOf: certificates.filter {
            if let t = $0.vaccinationCertificate.hcert.dgc.t?.first, !t.isPositive, !t.isValid {
                return true
            }
            return false
        })
        // #10 Now add everything that did not match any of the rules above
        res.append(contentsOf: certificates.filter { !res.contains($0) })

        return res
    }
}
