//
//  ListViewController.swift
//  CoreDataFundamentals
//
//  Created by Ankith K on 29/06/24.
//

import UIKit

class ListViewController:UIViewController{
        
    var movieView:MovieList!
    var viewModel:ListViewModel
    
    let cellIdentifier = "DefaultCell"
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel:ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    fileprivate func setupVM() {
        movieView = MovieList(frame: view.frame)
        view.addSubview(movieView)
        view.backgroundColor = .green
        
        movieView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        movieView.tableView.delegate = self
        movieView.tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        setupNavController()
        viewModel.loadData()
        setupVM()        
    }
    
    func setupNavController(){
        
        
        let navItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(showItemCreator))
        
        navigationController?.navigationItem.rightBarButtonItem = navItem
        navigationController?.title = "Favourite Movies!"
        navigationController?.navigationBar.isHidden = false
    }
    
    
    @objc func showItemCreator(){
        debugPrint("Do navigation!")
    }
}

extension ListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieView.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.text = viewModel.dataList[indexPath.row].name
        
        cell.contentConfiguration = contentConfig
        
        return cell
        
    }
}

extension ListViewController:UITableViewDelegate{
    
}

