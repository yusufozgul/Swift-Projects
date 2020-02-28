//
//  DetailViewController.swift
//  ContextMenu
//
//  Created by Yusuf Özgül on 26.02.2020.
//  Copyright © 2020 Yusuf Özgül. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{
    var selectedText: String?
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let label = UILabel()
        label.text = "Selected Row: \(selectedText ?? "NO TEXT")"
        label.sizeToFit()
        label.center = view.center
        self.view.addSubview(label)
        self.view.backgroundColor = .systemBackground
    }
    
    init(selectedText: String) {
        super.init(nibName: nil, bundle: nil)
        self.selectedText = selectedText
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
}
