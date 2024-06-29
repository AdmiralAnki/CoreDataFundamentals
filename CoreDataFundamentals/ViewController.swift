//
//  ViewController.swift
//  CoreDataFundamentals
//
//  Created by Ankith on 28/06/24.
//

import UIKit

class ViewController: UIViewController {

    var submitButton:UIButton!
    var textField:UITextField
    let storageProvider:StorageProvider
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
    }

    init(storageProvider:StorageProvider) {
        self.submitButton = ViewController.createButton()
        self.textField = ViewController.creatTextField()
        self.storageProvider = storageProvider
        super.init(nibName: nil, bundle: nil)
        
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    static func createButton()->UIButton{
        
        var button = UIButton(configuration: .filled())
        button.setTitle("Submit", for: .normal)
       
        
        return button
    }
    
    static func creatTextField()->UITextField{
                
        var textField = UITextField(frame: .zero)
        textField.placeholder = "Enter a movie name"
        textField.keyboardType = .namePhonePad
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.adjustsFontSizeToFitWidth = true
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        return textField
    }
    
    @objc func submitNewMovie(){
        if let name = textField.text{
            storageProvider.saveMovie(named: name)
        }else{
            debugPrint("No text entered!!")
        }
    }
    
    
    func layoutViews(){
    
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(textField)
        view.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50)
            ])
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            submitButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12),
            submitButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15)
        ])
        
        
        submitButton.addTarget(self, action: #selector(submitNewMovie), for: .touchUpInside)
    }
}

