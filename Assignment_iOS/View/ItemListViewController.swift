//
//  ItemListViewController.swift
//  Assignment_iOS
//
//  Created by apple on 12/04/25.
//

import UIKit

class ItemListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tbldata: UITableView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    let viewModel = ItemListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tbldata.reloadData()
            }
        }
        self.tbldata.delegate = self
        self.tbldata.dataSource = self
        tbldata.register(UITableViewCell.self, forCellReuseIdentifier: "ItemCell")
        viewModel.fetchFromAPI()
        applyDynamicColors()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ThemeManager.applyTheme(ThemeManager.currentTheme)
    }
    
    @IBAction func btnback(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = item.name
        let (color, capacity) = viewModel.getItemColorAndCapacity(for: item)
        if let color = color, let capacity = capacity {
            content.secondaryText = "Color: \(color), Capacity: \(capacity)"
        } else if let color = color {
            content.secondaryText = "Color: \(color)"
        } else if let capacity = capacity {
            content.secondaryText = "Capacity: \(capacity)"
        } else {
            content.secondaryText = "No additional data available"
        }
        cell.contentConfiguration = content
        return cell
    }
    
    func applyDynamicColors() {
        view.backgroundColor = UIColor.systemBackground
        baseView.backgroundColor = UIColor.secondarySystemBackground
        backButton.tintColor = UIColor.systemBlue
        tbldata.backgroundColor = UIColor.systemBackground
    }
}
