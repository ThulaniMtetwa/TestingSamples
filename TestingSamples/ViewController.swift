//
//  ViewController.swift
//  TestingSamples
//
//  Created by Thulani Mtetwa on 2023/05/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let apiCaller = AuthRepo(httpClient: HTTPClientImplementation())

        apiCaller.login(using: "thulanimtetwa@gmail.com", and: "dMgCycG99hood9", completionHandler: { result in
            switch result {
            case .success(let success):
                dump(success)
            case .failure(let failure):
                dump(failure)
            }
        })
    }
}

