//
//  ViewController.swift
//  CoreDataFundamentals
//
//  Created by Ankith on 28/06/24.
//

import UIKit

class AddMovieViewController: UIViewController {

    enum Mode{
        case edit
        case add
    }
    
    var submitButton:UIButton!
    var textField:UITextField
    let storageProvider:StorageProvider
    var dismissAction:()->()
    var movie:Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        self.title = "Add a new movie"
        layoutViews()
        
        if let movie{
            textField.text = movie.title
        }else{
            textField.text = ""
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissVC))
    }

    init(storageProvider:StorageProvider,movie:Movie?, dismissAction:@escaping ()->()) {
        self.submitButton = AddMovieViewController.createButton()
        self.textField = AddMovieViewController.creatTextField()
        self.storageProvider = storageProvider
        self.dismissAction = dismissAction
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func dismissVC(){
        self.dismissAction()
        self.dismiss(animated: true)
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
            if let movie{
                movie.title = name
                storageProvider.updateMovie()
            }else{
                storageProvider.saveMovie(named: name)
            }
            self.dismissVC()
        }else{
            debugPrint("No text entered!!")
        }
    }
    
    
    func layoutViews(){
    
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(textField)
        view.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.10),
            textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50)
            ])
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            submitButton.heightAnchor.constraint(equalToConstant: 80),
            submitButton.widthAnchor.constraint(equalToConstant: 160),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15)
        ])
        
        
        submitButton.addTarget(self, action: #selector(submitNewMovie), for: .touchUpInside)
    }
}

