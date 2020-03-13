//
//  InitialViewController.swift
//  SQLiteViewer
//
//  Created by Ezhil Adhavan Ananthavel on 12/03/20.
//  Copyright © 2020 Ezhil Adhavan. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.copyTestDatabase()
    }
    
    func copyTestDatabase() -> URL? {
        let filer = FileManager.default
        
        do {
            let docs = filer.urls(for: .documentDirectory, in: .userDomainMask).first!
            let target = docs.appendingPathComponent("Demo.db")
            let source = Bundle.main.url(forResource: "Demo", withExtension: "db")!
            print("Copying test database to \(target)...")
            try filer.copyItem(at: source, to: target)
            return target
        } catch {
            print("Error copying test database")
            print(error)
        }
        
        return nil
    }

    @IBAction func browseButtonAction(_ sender: Any) {
        let customURL = URL(fileURLWithPath: NSHomeDirectory())
        let sandboxBrowser = SandboxBrowser.init(initialPath: customURL)
        sandboxBrowser.didSelectFile = { file, vc in
            print(file.name, file.type)
            sandboxBrowser.dismiss(animated: true) {
                self.openTablesFromDB(file: file)
            }
        }
        DispatchQueue.main.async {
            self.present(sandboxBrowser, animated: true, completion: nil)
        }
    }
    
    private func openTablesFromDB(file: FileItem) {
        let tVC = TablesViewController()
        tVC.url = URL(fileURLWithPath: file.path)
        tVC.name = file.name
        self.navigationController?.pushViewController(tVC, animated: true)
    }
}

