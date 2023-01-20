//
//  ViewControllerExt.swift
//  RxSpace
//
//  Created by Aishwarya Aneja on 1/20/23.
//

import Foundation
import UIKit
import Alamofire
import SDWebImage



extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitles.count {
            return headerTitles[section]
        }

        return nil
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else{
            return launch_arr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! InfoCell
            cell.info_lbl.text = "\(getInfo?.name ?? "") was founded by \(getInfo?.founder ?? "") in \(getInfo?.founded ?? 0). It has now \(getInfo?.employees ?? 0) employees, \(getInfo?.launchSites ?? 0) launch sites and is valued at USD \(getInfo?.valuation ?? 0)"
            return cell
            
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchCell", for: indexPath) as! LaunchCell
            let get_launch_arr = launch_arr[indexPath.row]
            let getImageUrl = URL(string: get_launch_arr.links.patch.small ?? "")
            cell.launch_img.sd_setImage(with: getImageUrl, placeholderImage: nil)
            cell.mission_lbl.text = get_launch_arr.name
            cell.rocket_lbl.text = get_launch_arr.rocket
            cell.date_lbl.text = get_launch_arr.dateLocal
            
            if get_launch_arr.success == false{
                cell.success_img.image = UIImage(named: "cross")
            }
            else{
                cell.success_img.image = UIImage(named: "check")
            }
            
            let tapGesture = UITapGestureRecognizer.init()
            tapGesture.addTarget(self, action: #selector(action_tapView(_:)))
            cell.main_View.addGestureRecognizer(tapGesture)
            cell.main_View.tag = indexPath.row
            return cell
            
        }
        
       
    }
    
    @objc func action_tapView(_ sender:UITapGestureRecognizer){
        let inde = sender.view?.tag ?? 0
        let get_launch_arr = launch_arr[inde]
        var openUrl = ""
                
        let alert = UIAlertController(title: "Alert", message: "Please Select an Option", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Article", style: .default , handler:{ (UIAlertAction)in
                print("User click article button")
                
                openUrl = get_launch_arr.links.article ?? ""
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
                vc.webUrl = openUrl
                self.navigationController?.pushViewController(vc, animated: true)
                
            }))
            
            alert.addAction(UIAlertAction(title: "Wikipedia", style: .default , handler:{ (UIAlertAction)in
                print("User click wiki button")
                
                openUrl = get_launch_arr.links.wikipedia ?? ""
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
                vc.webUrl = openUrl
                self.navigationController?.pushViewController(vc, animated: true)
                
            }))

            alert.addAction(UIAlertAction(title: "Video", style: .destructive , handler:{ (UIAlertAction)in
                print("User click youtube button")
                
                openUrl = get_launch_arr.links.youtubeID ?? ""
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
                vc.youtubeId = openUrl
                self.navigationController?.pushViewController(vc, animated: true)
            }))

            self.present(alert, animated: true, completion: {
                print("completion block")
                
            })
    }
}

class InfoCell :UITableViewCell{
    @IBOutlet weak var info_lbl :UILabel!
}

class LaunchCell :UITableViewCell{
    @IBOutlet weak var launch_img :UIImageView!
    @IBOutlet weak var mission_lbl :UILabel!
    @IBOutlet weak var date_lbl :UILabel!
    @IBOutlet weak var rocket_lbl :UILabel!
    @IBOutlet weak var day_lbl :UILabel!
    @IBOutlet weak var success_img :UIImageView!
    @IBOutlet weak var main_View :UIView!
}


extension String{
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy"

        if let date = inputFormatter.date(from: dateString) {

            let outputFormatter = DateFormatter()
          outputFormatter.dateFormat = format

            return outputFormatter.string(from: date)
        }

        return nil
    }
}
