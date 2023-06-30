//
//  ViewModel.swift
//  RadiusAssignment
//
//  Created by Ashok Rawat on 29/06/23.
//

import Foundation

protocol ViewModelPresenter: AnyObject {
    func reload()
    func startLoading()
    func stopLoading()
    func showToast(message: String, isToast: Bool)
}

class FacilityViewModel {
    
    private let networkService: NetworkService
    var selectedFacility = [Int : FacilityExclusion]()
    var facilityData: FacilityData?
    weak var presenter: ViewModelPresenter?
    var activeOptions: [String: String] = [:]
    
    init(networkService: NetworkService = NetworkManager()) {
        self.networkService = networkService
    }
    
    // MARK: - API Call
    
    func fetchFacilityData() {
        presenter?.startLoading()
        guard let url =  URL(string: Constants.API.baseURL) else {
            presenter?.showToast(message: Constants.invalidURL, isToast: false)
            return
        }
        networkService.executeRequest(url: url, modelType: FacilityData.self) { [weak self] (data, error) in
            self?.presenter?.stopLoading()
            if error != nil {
                self?.presenter?.showToast(message: error?.localizedDescription ?? Constants.unKnown, isToast: false)
            }
            guard let data = data else {
                self?.presenter?.showToast(message: Constants.invalidDataDecode, isToast: false)
                return
            }
            self?.facilityData = data
            self?.presenter?.reload()
        }
    }
}

extension FacilityViewModel {
    
    var numberOfSections: Int {
        return facilityData?.facilities.count ?? 0
    }
    
    var heightForRow: CGFloat {
        return 60
    }
    
    func getNumberOfRows(in section: Int) -> Int {
        return facilityData?.facilities[section].options.count ?? 0
    }
    
    func getTitleForSection(in section: Int) -> String {
        return facilityData?.facilities[section].name ?? ""
    }
}

// MARK: - Cell actions

extension FacilityViewModel {
    func didSelectOption(at indexPath: IndexPath) {
        if let _ = facilityData,
           let facility = facilityData?.facilities[indexPath.section] {
            let option = facility.options[indexPath.row]
            
            if isOptionExcludedForFacility(at: indexPath) {
                presenter?.showToast(message: Constants.invalidCombination, isToast: true)
                return
            }
            activeOptions[facility.facilityId] = option.id
            presenter?.reload()
        }
    }
    
    func optionsForCellAtRowIndexPath(at indexPath: IndexPath) -> (FacilityOption?, Bool) {
        if let facility = facilityData?.facilities[indexPath.section] {
            let option = facility.options[indexPath.row]
            let isHiddenCehckMark = activeOptions[facility.facilityId] == option.id
            return (option: option, isHiddenCehckMark: isHiddenCehckMark)
        }
        return (option: nil, isHiddenCehckMark: false)
    }
    
    func isOptionExcludedForFacility(at indexPath: IndexPath) -> Bool {
        if let facilityCurrentData = facilityData,
           let facility = facilityData?.facilities[indexPath.section] {
            let option = facility.options[indexPath.row]
            for exclusionGroup in facilityCurrentData.exclusions {
                if let exclusion = exclusionGroup.first(where: { $0.facilityId == facility.facilityId }), exclusion.optionsId == option.id {
                    let excludedFacilityID = exclusionGroup.filter { $0.facilityId != facility.facilityId }.map { $0.facilityId }
                    let excludedOptionID = exclusionGroup.filter { $0.facilityId != facility.facilityId }.map { $0.optionsId }
                    
                    if let activeFacilityID = excludedFacilityID.first,
                       let activeOptionID = activeOptions[activeFacilityID],
                       excludedOptionID.contains(activeOptionID) {
                        
                        return true
                    }
                }
            }
        }
        return false
    }
}
