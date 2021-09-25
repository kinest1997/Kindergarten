//
//  BountyViewController.swift
//  BountyList
//
//  Created by 강희성 on 2021/09/16.
//

import UIKit

class BountyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    let nameList = ["brook", "chopper","franky","luffy","nami","robin","sanji","zoro"]
    let bountyList = [33000000,50,44000000,300000000,16000000,80000000,77000000,120000000]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bountyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            as? ListCell else{
               return UITableViewCell()
            }
        let img = UIImage(named: "\(nameList[indexPath.row]).jpg")
        cell.imgView.image = img
        cell.nameLabel.text = nameList[indexPath.row]
        cell.bountyLabel.text = "\(bountyList[indexPath.row])"
        return cell
   
    }


//UITableViewDeligate
func tableView(_ tableView : UITableView,
               didSelectRowAt indexPath : IndexPath) {
    print("--> \(indexPath.row)")
}



class ListCell : UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
}
}
