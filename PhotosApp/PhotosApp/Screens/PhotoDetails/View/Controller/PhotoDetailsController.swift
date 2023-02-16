//
//  PhotoDetailsController.swift
//  PhotosApp
//
//  Created by Rajeswaran Thangaperumal on 16/02/23.
//

import UIKit

class PhotoDetailsController: UIViewController {
    
    @IBOutlet weak var nameTextView: UITextView!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var albumIDPlaceholder: UILabel!
    
    @IBOutlet weak var albumIDLabel: UILabel!
    
    @IBOutlet weak var photoName: UILabel!
    
    var viewModel: PhotoDetailsViewModel?
    
    var changeTitle: ((PhotoDetailsViewModel) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let vm = viewModel {
            setViewModel(data: vm)
        }
        
        self.title = Appconstant.photoDetails
        addDoneButton()
        saveButtonAppearance()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textViewAppearacnce()
        saveButton.layer.cornerRadius = 10
    }
    
    //MARK: View Appearcace
    private func textViewAppearacnce(){
        let color = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
        nameTextView.layer.borderColor = color
        nameTextView.layer.borderWidth = 0.5
        nameTextView.layer.cornerRadius = 5
    }
    private func saveButtonAppearance(){
        saveButton.setTitle(Appconstant.saveChanges, for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.setTitleColor(.white, for: .normal)
    }
    
    //MARK: Keyboard Accessory
    private func addDoneButton(){
        let keyboardToolbar = UIToolbar()
          keyboardToolbar.sizeToFit()
          let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
              target: nil, action: nil)
          let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
              target: view, action: #selector(UIView.endEditing(_:)))
          keyboardToolbar.items = [flexBarButton, doneBarButton]
          nameTextView.inputAccessoryView = keyboardToolbar
    }
    
    
    //MARK: ViewModel Binding
    func setViewModel(data:PhotoDetailsViewModel){
        nameTextView.text = data.photoName
        photoImageView.load(urlString: data.photImageUrl)
        self.albumIDLabel.text = "\(data.id)"
        self.albumIDPlaceholder.text = Appconstant.albumID
        self.photoName.text = Appconstant.photoName
    }
    
    
    //MARK: Change Button Action
    @IBAction func changeAction(_ sender: UIButton){
        let name = nameTextView.text.trimmingCharacters(in: .whitespaces)
        if name.count > 5 {
            var vm = viewModel
            vm?.photoName = nameTextView.text ?? ""
            if let handler = changeTitle,let viewModelObj = vm {
                handler(viewModelObj)
                self.showToast(message: Appconstant.updateSuccess)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }else{
            self.showToast(message: Appconstant.nameValidation)
        }
        
    }
}
