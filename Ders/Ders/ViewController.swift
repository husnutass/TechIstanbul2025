//
//  ViewController.swift
//  Ders
//
//  Created by Hüsnü Taş on 28.08.2025.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
        
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change to SwiftUI", for: .normal)
        button.addTarget(self, action: #selector(toggleTheme), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var hostingController: UIHostingController<SwiftUIView>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
    }
    
    private func setup() {
        view.addSubview(tableView)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            button.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc func toggleTheme() {
        if hostingController != nil {
            changeToUIKit()
        } else {
            changeToSwiftUI()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Row \(indexPath.row)"
        return cell
    }
}

extension ViewController {
    func changeToSwiftUI() {
        hostingController = UIHostingController(rootView: SwiftUIView(onChange: toggleTheme))
        view.addSubview(hostingController.view)
        hostingController.view.frame = view.bounds
        hostingController.didMove(toParent: self)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    func changeToUIKit() {
        hostingController.willMove(toParent: nil)
        hostingController.view.removeFromSuperview()
        hostingController.removeFromParent()
        hostingController = nil
        
        navigationController?.navigationBar.isHidden = false
    }
}

// MARK: - SwiftUI

struct SwiftUIView: View {
    var onChange: (() -> Void)?
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(0..<100, id: \.self) { index in
                        Text("Item \(index)")
                    }
                }
                
                Button("Change to UIKit") {
                    onChange?()
                }
            }
        }
    }
}

#Preview {
    ViewController()
}

#Preview {
    SwiftUIView()
}
