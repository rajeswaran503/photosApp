//
//  PhotosViewModel.swift
//  PhotosApp
//
//  Created by Rajeswaran on 16/02/23.
//

import Foundation


protocol ViewStateDelegate {
    func showAlert(message:String)
    func showLoader(show:Bool)
}


final class PhotosViewModel {
    
    private var photos:[Photo]?
    
    private var services:PhotosListServiceProtocol
    
    var delegate: ViewStateDelegate?
    
    var reloadTableView: (() -> Void)?
    
    init(services:PhotosListServiceProtocol) {
        self.services = services
    }
}

extension PhotosViewModel {
    func fetchAllPhotos(){
        
        if !Reachability.isConnectedToNetwork(){
            if let viewDelegate = delegate {
                viewDelegate.showAlert(message: Appconstant.networkReachbility)
            }
            return
        }
        self.setLoaderState(show: true)
        services.getPhotos {[weak self] (photoResponse, message) in
            self?.setLoaderState(show: false)
            if let responseData = photoResponse {
                self?.photos = responseData
                if let handler = self?.reloadTableView {
                    handler()
                }
            }
            
            if let error = message {
                if let delegateObj = self?.delegate {
                    delegateObj.showAlert(message: error)
                }
            }
        }
    }
    
    
    var noOfPhotos:Int{
        guard let nos = photos else { return 0 }
        return nos.count
    }
    
    func getPhoto(indexPath:IndexPath) -> Photo? {
        return self.photos?[indexPath.row]
    }
    
    
     func getCellListViewModel(indexpath:IndexPath) -> PhotoCellViewModel {
        guard let photoList = self.photos else { return PhotoCellViewModel(photoName: "", photoThumUrl: "") }
        let photo = photoList[indexpath.row]
        return PhotoCellViewModel(photoName: photo.title ?? "", photoThumUrl: photo.thumbnailUrl ?? "")
    }
    
     func getCellDetailsViewModel(indexpath:IndexPath) -> PhotoDetailsViewModel{
        guard let photoList = self.photos else { return PhotoDetailsViewModel(photoName: "", photImageUrl: "", id: 0) }
        let photo = photoList[indexpath.row]
        return PhotoDetailsViewModel(photoName: photo.title ?? "", photImageUrl: photo.url ?? "", id: photo.id ?? 0)
    }
    
    func setLoaderState(show:Bool){
        if let viewDelegate = delegate {
            DispatchQueue.main.async {
                viewDelegate.showLoader(show: show)
            }
           
        }
    }
    
    
    func updatePhotoDetails(id:Int,title:String,completion:@escaping(Int) -> Void) {
        if let firstIndex = self.photos?.firstIndex(where: {$0.id == id}) {
            self.photos?[firstIndex].title = title
            completion(firstIndex)
        }
    }
}
