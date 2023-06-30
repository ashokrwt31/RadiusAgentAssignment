//
//  ViewController.swift
//  RadiusAssignment
//
//  Created by Ashok Rawat on 29/06/23.
//

import UIKit

class FacilityViewController: UIViewController {
    
    @IBOutlet weak var facilityTableView: UITableView!
    private var viewModel = FacilityViewModel()
    private let indicator = ActivityIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.presenter = self
        setupTableView()
        fetchFacilityFromServer()
    }
    
    private func setupTableView() {
        facilityTableView.register(OptionTableViewCell.self, forCellReuseIdentifier: Constants.UI.OptionTableViewCell)
    }
}

extension FacilityViewController {
   private func fetchFacilityFromServer() {
        viewModel.fetchFacilityData()
    }
}

extension FacilityViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = viewModel.optionsForCellAtRowIndexPath(at: indexPath)
        guard let option = result.0 else {
            return UITableViewCell()
        }
        
        
        let isExculed = viewModel.isOptionExcludedForFacility(at: indexPath)
        let cell = facilityTableView.dequeueReusableCell(withIdentifier: Constants.UI.OptionTableViewCell, for: indexPath) as! OptionTableViewCell
        cell.configureCell(with: option, isHiddenCehckMark: result.1, isExculed: isExculed)
        return cell
    }
}

extension FacilityViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getTitleForSection(in: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectOption(at: indexPath)
        facilityTableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow
    }
}

extension FacilityViewController: ViewModelPresenter {
    
    func reload() {
        DispatchQueue.main.async {
            self.facilityTableView.reloadData()
        }
    }
    
    func startLoading() {
        indicator.startIndicatorView(uiView: self.view, style: .medium)
    }
    
    func stopLoading() {
        indicator.hideIndicatorView()
    }
    
    func showToast(message: String, isToast: Bool) {
        if (isToast) {
            showToast(message: message)
        }
        else {
            UIAlertController.showAlert(title: "Error", message: message, viewController: self)
        }
    }
}
