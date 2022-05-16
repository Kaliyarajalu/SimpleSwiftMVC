//
//  ViewController.swift
//  SimpleSwiftMVC
//
//  Created by Apple on 16/05/22.
//

import UIKit
import Alamofire
import ContentLoader

class ViewController: UIViewController {
    
    //
    // MARK: - Declarations
    //
    var responseArray = [DataModel]()
    
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        callAPI()
    }
    
    //
    // MARK: - Call API
    //
    
    func callAPI() {
        startContentwithFormat()
        Alamofire.request(URL(string: Constants.clientApi)!, method: .get,
                          parameters: nil,
                          headers: nil)
            .responseJSON { response in
                if let responseData = response.data {
                    do {
                        let decodeJson = JSONDecoder()
                        decodeJson.keyDecodingStrategy = .convertFromSnakeCase
                        self.responseArray =  try decodeJson.decode([DataModel].self, from: responseData)
                        self.tableView.hideLoading()
                        self.tableView.reloadData()
                    } catch {
                        // Catch the error and handle it.
                        print("error")
                    }
                }
            }
    }
        
    //
    // MARK: - Format Content Loader
    //
    
    func startContentwithFormat() {
        var format = ContentLoaderFormat()

        /// Loader objects color
        format.color = UIColor.lightGray

        /// Loader objects corner radius
        format.radius = 5

        /// Loader animation type
        format.animation = .fade
        
        tableView.startLoading(format: format)
    }
}

//
// MARK: - Extensions
//

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        responseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
        cell.firstLabel?.text = String(responseArray[indexPath.row].id ?? 0)
        cell.secondLabel?.text = String(responseArray[indexPath.row].title ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82.0
    }
}

extension ViewController: ContentLoaderDataSource {
    
    func numSections(in contentLoaderView: UIView) -> Int {
        return 1
    }
    
    func contentLoaderView(_ contentLoaderView: UIView, numberOfItemsInSection section: Int) -> Int {
        return self.responseArray.count
    }
    
    func contentLoaderView(_ contentLoaderView: UIView, cellIdentifierForItemAt indexPath: IndexPath) -> String {
        return CustomCell.identifier
    }
}
