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
    
     
    override func viewDidLoad() {
        setupNavController()
        setupMovieView()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        reloadData()
    }
    
    fileprivate func setupMovieView() {
        view.backgroundColor = .green
        
        movieView = MovieList(frame: .zero)
        movieView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        movieView.tableView.delegate = self
        movieView.tableView.dataSource = self
        
        view.addSubview(movieView)
        
        movieView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieView.topAnchor.constraint(equalTo: view.topAnchor),
            movieView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
 
    func setupNavController(){
        let navItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(showItemCreator))
        self.navigationItem.rightBarButtonItem = navItem
        self.title = "Favourite Movies!"
    }
    
    fileprivate func reloadData() {
        viewModel.loadData()
        movieView.tableView.reloadData()
    }
    
    @objc func showItemCreator(){
        showMovieEditor()
    }
    
    
    
    fileprivate func showMovieEditor(movie:Movie? = nil) {
        let addMovieViewController = AddMovieViewController(storageProvider: viewModel.storageProvider, movie: movie, dismissAction: {
            self.reloadData()
        })
        addMovieViewController.modalPresentationStyle = .pageSheet
        
        let navCon = UINavigationController(rootViewController: addMovieViewController)
        self.present(navCon, animated: true)
    }
    
}

extension ListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        debugPrint("data count",viewModel.dataList.count)
        return viewModel.dataList.count
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { _,_,completionHandler in
            self.viewModel.removeData(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    //allow editing
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var movie = viewModel.dataList[indexPath.row]
        showMovieEditor(movie: movie)
    
    }
}

