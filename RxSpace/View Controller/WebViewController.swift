//
//  WebViewController.swift
//  RxSpace
//
//  Created by Aishwarya Aneja on 1/20/23.
//

import Foundation
import UIKit


class WebViewController : UIViewController{
    
    @IBOutlet weak var webView: UIWebView!
    
    var webUrl = ""
    var youtubeId = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        if youtubeId != ""{
            loadYoutube(videoID: youtubeId)
        }
        else{
            loadWeb(webUrl: webUrl)
        }
        
    }
    
    func loadWeb(webUrl:String){
        let url = URL (string: webUrl)
                let requestObj = URLRequest(url: url!)
                webView.loadRequest(requestObj)
    }
    
    func loadYoutube(videoID:String) {
            guard
                let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)")
                else { return }
        webView.loadRequest( URLRequest(url: youtubeURL) )
        }
    
    
    @IBAction func back_action(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
