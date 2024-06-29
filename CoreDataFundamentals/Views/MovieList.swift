//
//  MovieList.swift
//  CoreDataFundamentals
//
//  Created by Ankith K on 29/06/24.
//

import UIKit

class MovieList: UIView {
    
    var tableView:UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)        
    }
    
    private func configureView(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .purple
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.backgroundColor = .brown
        
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.heightAnchor.constraint(equalTo: heightAnchor),
            tableView.widthAnchor.constraint(equalTo: widthAnchor),
            tableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

}

#Preview("test"){
    MovieList(frame: CGRect(x: 0, y: 0, width: 300, height: 600))
}

