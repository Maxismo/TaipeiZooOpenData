//
//  ViewController.swift
//  TaipeiZooOpenData
//
//  Created by Max Chen on 6/18/19.
//  Copyright © 2019 NotAnOrganization. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var plantTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var currentPage = 0
    private var totalCount = Int.max
    private let pageSize = 20
    
    private let headerTitle = "Taipei Zoo"
    private let headerHeight: CGFloat = 300
    private let headerHeightMin: CGFloat = 88
    private let headerView = HeaderView()
    
    private var plants: [Plant] = [] {
        didSet {
            DispatchQueue.main.async {
                self.plantTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
}

private extension ViewController {
    func setup() {
        setupHeader()
        
        setupTableview()
        
        getData()
    }
    
    func setupHeader() {
        plantTableView.contentInset = UIEdgeInsets(top: headerHeight, left: 0, bottom: 0, right: 0)
        
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: headerHeight)
        headerView.titleLabel.text = headerTitle
        view.addSubview(headerView)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .top, barMetrics: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        title = headerTitle
    }
    
    func setupTableview() {
        plantTableView.register(for: PlantTableViewCell.self)
        plantTableView.rowHeight = UITableView.automaticDimension
        plantTableView.dataSource = self
        plantTableView.delegate = self
    }
    
    func getData() {
        activityIndicator.isHidden = false
        
        if totalCount == plants.count {
            activityIndicator.isHidden = true
        } else {
            let parameters = [
                "scope": Constants.apiAccessScope,
                "rid": Constants.resourceId,
                "limit": "\(pageSize)",
                "offset": "\(currentPage * pageSize)"
            ]
            
            let request = Request(
                parameters: QueryParameters(parameters),
                resource: APIResponse<Plant>.init)
            
            let client = Client(baseURL: Constants.apiServerURL)
            
            client.perform(request) { [weak self] result in
                DispatchQueue.main.async {
                    self?.activityIndicator.isHidden = true
                }
                
                if let result = result?.result {
                    self?.totalCount = result.count
                    self?.plants.append(contentsOf: result.results)
                    self?.currentPage += 1
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if plants.count - 3 == indexPath.row {
            getData()
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: PlantTableViewCell.reuseIdentifier
            , for: indexPath) as? PlantTableViewCell {
            cell.info = plants[indexPath.row]
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension ViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = min(max(-scrollView.contentOffset.y, headerHeightMin), headerHeight)
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        
        navigationController?.navigationBar.isHidden = headerHeightMin != height
        headerView.titleLabel.isHidden = headerHeightMin == height
    }
}
