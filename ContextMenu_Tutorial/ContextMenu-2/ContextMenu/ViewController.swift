//
//  ViewController.swift
//  ContextMenu
//
//  Created by Yusuf Özgül on 26.02.2020.
//  Copyright © 2020 Yusuf Özgül. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myTableView: UITableView!
    
    var array = ["Armut", "Üzüm", "İncir", "Karpuz", "Muz", "Erik", "Elma", "Portakal", "Kavun"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
}

extension ViewController
{
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: "\(indexPath.row)" as NSCopying, previewProvider: {
            
            return DetailViewController(selectedText: self.array[indexPath.row])
        }) { action in
            let viewMenu = UIAction(title: "Go Detail VC", image: UIImage(systemName: "eye.fill"), identifier: UIAction.Identifier(rawValue: "view")) {_ in
                self.present(DetailViewController(selectedText: "\(indexPath.row)"), animated: true)
            }
            
            let deleteMenu = UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), identifier: nil) { (action) in
                self.array.remove(at: indexPath.row)
                tableView.reloadData()
            }
            let addMenu = UIAction(title: "Add", image: UIImage(systemName: "plus.rectangle.fill"), identifier: nil) { (action) in
                self.array.append(self.array.randomElement() ?? "")
                tableView.reloadData()
            }
            let secondMenu = UIMenu(title: "Edit", children: [deleteMenu, addMenu])
            return UIMenu(title: "", image: nil, identifier: nil, children: [viewMenu, secondMenu])
        }
        return config
    }
    
    func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        guard let destinationViewController = animator.previewViewController else { return }
        animator.addAnimations { self.present(destinationViewController, animated: true) }
    }
}
