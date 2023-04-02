//
//  TasksViewController.swift
//  Firebase practice
//
//  Created by Adlet Zhantassov on 02.04.2023.
//

import Foundation
import UIKit
import Firebase
import SnapKit

class TasksViewController: UIViewController {
    
    var user: User!
    var ref: DatabaseReference!
    var tasks = Array<Task>()
    
    //MARK: - Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
//        guard let currentUser = Auth.auth().currentUser else { return }
//        user = User(user: currentUser)
//        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("tasks")
    }
    
    @objc func addButtonPressed() {
        let alertController = UIAlertController(title: "New Task", message: "Add new task", preferredStyle: .alert)
        alertController.addTextField()
        let save = UIAlertAction(title: "SAVE", style: .default) { _ in
            guard let textField = alertController.textFields?.first, textField.text != "" else { return }
            
        }
        
        let cancel = UIAlertAction(title: "CANCEL", style: .cancel)
        alertController.addAction(save)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
    
    @objc func signOutPressed() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true)
    }
}

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOutPressed))
        title = "Tasks"
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "adlet"
        return cell
    }
    
    
}
