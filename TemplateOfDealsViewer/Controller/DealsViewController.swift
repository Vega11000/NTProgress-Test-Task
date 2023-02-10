//
//  DealsViewController.swift
//  TemplateOfDealsViewer
//
//  Created by Илья Калганов on 06.02.2023.
//

import UIKit

final class DealsViewController: UIViewController {

    private let server = Server()
    private let dealsView = DealsView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        view = dealsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToServer()
        navigationItem.leftBarButtonItem = dealsView.upDownDealsBarButton
        navigationItem.rightBarButtonItem = dealsView.sortBarButton
    }
}

private extension DealsViewController {
    func subscribeToServer() {
        server.subscribeToDeals { [self] deals in
            dealsView.dealsList.append(contentsOf: deals)
            dealsView.collectionView.reloadData()
        }
    }
}
