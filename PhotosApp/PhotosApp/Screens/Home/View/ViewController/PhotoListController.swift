//
//  PhotoListController.swift
//  PhotosApp
//
//  Created by Rajeswaran on 16/02/23.
//

import UIKit

class PhotoListController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var viewModel: PhotosViewModel?
    
    
    //MARK:  ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initViewModel()
        self.registerTableView()
        self.title = Appconstant.homeTitle
        self.getPhotosList()
    }
    
    private func initViewModel(){
        self.viewModel = PhotosViewModel(services: PhotosListService())
        self.viewModel?.delegate = self
        self.viewModel?.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    //MARK:  Encapsulation Method
    private func registerTableView(){
        tableView.register(PhotoListCell.nib, forCellReuseIdentifier: PhotoListCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func getPhotosList(){
        guard let vm = viewModel else { return}
        vm.fetchAllPhotos()
    }

}


//MARK: PhotoList Table DataSource
extension PhotoListController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoListCell.identifier, for: indexPath) as? PhotoListCell else { return UITableViewCell() }
        if let cellVM = viewModel?.getCellListViewModel(indexpath: indexPath) {
            cell.viewModel = cellVM
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vm = viewModel else { return 0 }
        return vm.noOfPhotos
    }
}

//MARK: PhotoList Table Delegate
extension PhotoListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cellVM = viewModel?.getCellDetailsViewModel(indexpath: indexPath) {
            self.moveToDetailsScreen(viewModel: cellVM)
        }
    }
}


//MARK: Navigations

extension PhotoListController:ViewStateDelegate {
    func showLoader(show: Bool) {
        if show {
            self.view.showActivityIndicator()
        }else {
            self.view.hideActivityIndicator()
        }
    }
    
    func moveToDetailsScreen(viewModel:PhotoDetailsViewModel){
        let detailVC = PhotoDetailsController()
        detailVC.viewModel = viewModel
        detailVC.changeTitle = {[weak self] photoObj in
            self?.reloadCell(data: photoObj)
        }
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func reloadCell(data:PhotoDetailsViewModel){
        viewModel?.updatePhotoDetails(id: data.id, title: data.photoName, completion: { [weak self] index in
            DispatchQueue.main.async {
                let indexPosition = IndexPath(row: index, section: 0)
                self?.tableView.reloadRows(at: [indexPosition], with: .none)
            }
        })
       
    }
   
}
