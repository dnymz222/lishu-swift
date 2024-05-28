//
//  LSSettingViewController.swift
//  lishu
//
//  Created by xueping wang on 2024/5/18.
//

import UIKit
import SnapKit


class LSSettingViewController: UIViewController {
    
    
    lazy var tableView: UITableView  = {
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = LSColorManager.share.viewBackgroundColor
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        
        
        
        return tableView
    }()
    
    
    lazy var datalist:[[String]] = [
                                 
                                    
                                 
                                    [NSLocalizedString("rate_on_app_store", comment: ""),
                                     NSLocalizedString("share_to_friends", comment: ""),
                                     NSLocalizedString("privacy_policy", comment: ""),
                                     NSLocalizedString("terms_of_service", comment: ""),
                                     NSLocalizedString("lan_setting", comment: ""),
                                     NSLocalizedString("version", comment: "")]
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = LSColorManager.share.viewBackgroundColor
        
        self.navigationItem.title = NSLocalizedString("tab_more", comment: "")
        
        
        if LSKeyManager.share.isChina() {
            datalist[0].append("App备案号")
         }
        
        
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
     
        
    }
    
    func activityShare() {
        
        
        guard let url = URL(string:  NSLocalizedString("app_url", comment: "")) ,
        let shareImge = UIImage(named: "lishu_icon")
                else {
            return
        }
       
        
        let shareUrl = url
        let title = NSLocalizedString("app_name", comment: "")
        
        let activityshareVc = UIActivityViewController(activityItems: [title,shareImge,shareUrl], applicationActivities: nil)
        
        activityshareVc.excludedActivityTypes = [.print,.saveToCameraRoll]
        
        
        if UIDevice.current.model.contains("iPad") {
            if let popover = activityshareVc .popoverPresentationController {
                let size = UIScreen.main.bounds
                popover.sourceView = tableView.cellForRow(at: IndexPath(row: 0, section: 1))
                
                popover.sourceRect = CGRect(x: size.width/2, y: size.height/2 - 200, width: 0, height: 0  )
              
                popover.permittedArrowDirections = .up
                
            }
        }
        
        self.navigationController?.present(activityshareVc, animated: true)
        
        
    }

    
    


}

extension LSSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let list = datalist[section]
        return list.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return datalist.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if let _ = cell {
            
        } else {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
            cell?.accessoryType = .disclosureIndicator
            cell?.detailTextLabel?.textColor = LSColorManager.share.textLightColor
            cell?.detailTextLabel?.font = .systemFont(ofSize: 14)
            cell?.backgroundColor = LSColorManager.share.cellBackgroundColor
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
            cell?.textLabel?.textColor = LSColorManager.share.textDarkColor
        }
        
        
        let list = datalist[indexPath.section]
        let string = list[indexPath.row]
        
        cell?.textLabel?.text = string
        
        if 0 == indexPath.section  && 5 == indexPath.row {
            if let text = Bundle.main.infoDictionary?["CFBundleShortVersionString"]  as? String{
                cell?.detailTextLabel?.text = text
            }
        } else if 0 == indexPath.section && 6 == indexPath.row {
            cell?.detailTextLabel?.text = "赣ICP备2023011753号-4A"
        }
        else {
            cell?.detailTextLabel?.text  = ""
        }
        
    
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if 0 == indexPath.section {
            if 0 == indexPath.row {
                
                let urlStr = String(format: "https://itunes.apple.com/us/app/itunes-u/id%@?action=write-review&mt=8", LSKeyManager.appId )
                if let url = URL(string: urlStr) {
                    let options = [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly: false]
                    UIApplication.shared.open(url,options: options)
                }
            } else if 1 == indexPath.row {
                self.activityShare()
            } else if 2 == indexPath.row {
                guard let url = URL(string: NSLocalizedString("privacy_url", comment: "")) else {
                    return
                }
                let vc = LSWKViewController()
                vc.url = url
                vc.navTitle = datalist[0][2]
                self.navigationController?.pushViewController(vc, animated: true)
               
            } else if 3 == indexPath.row {
                guard let url = URL(string: NSLocalizedString("service_url", comment: "")) else {
                    return
                }
                let vc = LSWKViewController()
                vc.url = url
                vc.navTitle = datalist[0][3]
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else if 4 == indexPath.row {
                if let url = URL(string:  UIApplication.openSettingsURLString) {
                    let options = [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly: false]
                    UIApplication.shared.open(url,options: options)
                }
                
            } else if 5 == indexPath.row {
                let urlStr = NSLocalizedString("app_url", comment: "")
                if let url = URL(string: urlStr) {
                    let options = [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly: false]
                    UIApplication.shared.open(url,options: options)
                }
            } else {
                let urlStr = "https://beian.miit.gov.cn"
                if let url = URL(string: urlStr) {
                    let options = [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly: false]
                    UIApplication.shared.open(url,options: options)
                }
            }
        }
        
        
    }
    
    
    
    
}

