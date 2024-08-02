//
//  LSSettingViewController.swift
//  lishu
//
//  Created by xueping wang on 2024/5/18.
//

import UIKit
import SnapKit
import CropViewController


class LSSettingViewController: UIViewController, UINavigationControllerDelegate {
    
    
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
    
    var headerView: LSProfileHeaderView?
    

    
    
    lazy var datalist:[String] = [
                                    NSLocalizedString("time", comment: ""),
                                     NSLocalizedString("lan_setting", comment: ""),
                                      NSLocalizedString("rate_on_app_store", comment: ""),
                                     NSLocalizedString("share_to_friends", comment: ""),
                                     NSLocalizedString("privacy_policy", comment: ""),
                                     NSLocalizedString("terms_of_service", comment: ""),
                                     NSLocalizedString("version", comment: "")]
    
    
    lazy var friendList:[String] = [NSLocalizedString("my_friend", comment: ""),
                                    NSLocalizedString("block", comment: "")]
    
    lazy var loginList:[String] = [NSLocalizedString("account_manager", comment: ""),
                                    NSLocalizedString("almanac_setting", comment: ""),
                                    NSLocalizedString("custom_date", comment: "")]
    
    
    
    lazy var unloginList:[String] = [NSLocalizedString("sign_in", comment: ""),
                                    NSLocalizedString("create_account", comment: "")]
    
    
    lazy var prolist:[String] = [ NSLocalizedString("upgrage_pro", comment: ""),
                                  NSLocalizedString("restore", comment: "")
                            
                                    ]
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = LSColorManager.share.viewBackgroundColor
        
        self.navigationItem.title = NSLocalizedString("tab_more", comment: "")
        
        
        if LSKeyManager.share.isChina() {
            datalist.append("App备案号")
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
    
    func timeSelect() {
        let alertVc = UIAlertController(title: NSLocalizedString("select_time", comment: ""), message: nil, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "12h", style: .default) { _ in
    
            LSKeyManager.share.configTwelve(true)
            
           
            self.tableView.reloadData()
            
           
        }
        
       
        
        let action2 = UIAlertAction(title: "24h", style: .default) { _ in
            LSKeyManager.share.configTwelve(false)
            self.tableView.reloadData()
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: EMLocationManager.timeChangeNoteKey) , object: nil)
          
        }
        
        let action3 = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style:.destructive) { _ in
            
        }
        alertVc.addAction(action1)
        alertVc.addAction(action2)
        alertVc.addAction(action3)
        
        // ipad
        
        if UIDevice.current.model.contains("iPad") {
            if let popover = alertVc.popoverPresentationController {
                let size = UIScreen.main.bounds
                popover.sourceView = tableView.cellForRow(at: IndexPath(row: 0, section: 2))
                
                popover.sourceRect = CGRect(x: size.width/2, y: size.height/2 - 100, width: 0, height: 0  )
              
                popover.permittedArrowDirections = .up
                
            }
        }
        
        self.navigationController?.present(alertVc, animated: true)
        
    }
    
    
     func selectProfileImage() {
            let alert = UIAlertController(title: "选择图片来源", message: nil, preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "从相册选择", style: .default, handler: { action in
                self.pickImageFromLibrary()
            }))
            
            alert.addAction(UIAlertAction(title: "从相机拍照", style: .default, handler: { action in
                self.pickImageFromCamera()
            }))
            
            alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
         
         if UIDevice.current.model.contains("iPad") {
             if let popover = alert.popoverPresentationController {
                 let size = UIScreen.main.bounds
                 popover.sourceView = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
                 
                 popover.sourceRect = CGRect(x: size.width/2, y: size.height/2 - 100, width: 0, height: 0  )
               
                 popover.permittedArrowDirections = .up
                 
             }
         }
         
            
         self.navigationController?.present(alert, animated: true, completion: nil)
        }
        

    
    @objc
    func profileTap() {
        
        selectProfileImage()
        
    }
    
    func pickImageFromLibrary() {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
    
    func pickImageFromCamera() {
          if UIImagePickerController.isSourceTypeAvailable(.camera) {
              let imagePicker = UIImagePickerController()
              imagePicker.delegate = self
              imagePicker.sourceType = .camera
              self.present(imagePicker, animated: true, completion: nil)
          }
      }

}

extension LSSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if 0 == section {
            if LSUserManager.share.isLogin {
                return loginList.count
            } else {
                return unloginList.count
            }
        } else if 1 == section {
            return prolist.count
        }
        
        else if 2 == section {
            return friendList.count
        } else {
            return datalist.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  4
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if 0 == section {
            return 250
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if  0 == section {
            var header: LSProfileHeaderView? = tableView.dequeueReusableHeaderFooterView(withIdentifier: "profile") as? LSProfileHeaderView
            if let _ = header {
                
            } else {
                header = LSProfileHeaderView(reuseIdentifier: "profile")
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(profileTap))
                header?.iconView.addGestureRecognizer(tap)
                self.headerView = header
            }
            
            if LSUserManager.share.isLogin {
                
            } else {
                header?.configNoLogin()
            }
         
            return header!
        } else {
            var header: LSNormalHeaderView? = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? LSNormalHeaderView
            if let _ = header {
                
            } else {
                header = LSNormalHeaderView(reuseIdentifier: "header")
            }
            
            if 1 == section {
                header?.titleLabel.text = NSLocalizedString("go_pro", comment: "")
            }else if 2 == section {
                header?.titleLabel.text = NSLocalizedString("my_friends", comment: "")
            } else {
                header?.titleLabel.text = NSLocalizedString("app_setting", comment: "")
            }
            
            return header!
        }
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
        
        if 0 == indexPath.section {
            if LSUserManager.share.isLogin {
                let string = loginList[indexPath.row]
                
                cell?.textLabel?.text = string
                cell?.detailTextLabel?.text  = ""
            } else {
                let string = unloginList[indexPath.row]
                
                cell?.textLabel?.text = string
                cell?.detailTextLabel?.text  = ""
            }
            
        } else if 1 == indexPath.section {
            
            let string = prolist[indexPath.row]
            
            cell?.textLabel?.text = string
            cell?.detailTextLabel?.text  = ""
            
        }
        
        
        else if 2 == indexPath.section {
            
            let string = friendList[indexPath.row]
            
            cell?.textLabel?.text = string
            cell?.detailTextLabel?.text  = ""
            
        }else if 3 == indexPath.section {
            
            let string = datalist[indexPath.row]
            
            cell?.textLabel?.text = string
            
            if 2 == indexPath.section  && 6 == indexPath.row {
                if let text = Bundle.main.infoDictionary?["CFBundleShortVersionString"]  as? String{
                    cell?.detailTextLabel?.text = text
                }
            } else if 2 == indexPath.section && 7 == indexPath.row {
                cell?.detailTextLabel?.text = "赣ICP备2023011753号-4A"
            }
            else {
                cell?.detailTextLabel?.text  = ""
            }
        }
        
    
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if 0 == indexPath.section {
            if LSUserManager.share.isLogin {
                if 0 == indexPath.row {
                    
                    let accountsettingVC = LSAccountSettingViewController()
                    self.navigationController?.pushViewController(accountsettingVC, animated: true)
                    
                } else if 1 == indexPath.row {
                    
                }
                
                
            } else {
                if 0 == indexPath.row {
                    
                } else if 1 == indexPath.row {
                    
                    let vc = LSRegisterViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        } else if 1 == indexPath.section {
            if 0 == indexPath.row {
                let vc = LSPremiumViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        } else if 2 == indexPath.section {
            
            
        }else if 3 == indexPath.section {
            if 0 == indexPath.row {
                self.timeSelect()
            } else if 1 == indexPath.row {
                if let url = URL(string:  UIApplication.openSettingsURLString) {
                    let options = [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly: false]
                    UIApplication.shared.open(url,options: options)
                }
                
            }else if 2 == indexPath.row {
                
                let urlStr = String(format: "https://itunes.apple.com/us/app/itunes-u/id%@?action=write-review&mt=8", LSKeyManager.appId )
                if let url = URL(string: urlStr) {
                    let options = [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly: false]
                    UIApplication.shared.open(url,options: options)
                }
            } else if 3 == indexPath.row {
                self.activityShare()
            } else if 4 == indexPath.row {
                guard let url = URL(string: NSLocalizedString("privacy_url", comment: "")) else {
                    return
                }
                let vc = LSWKViewController()
                vc.url = url
                vc.navTitle = datalist[4]
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else if 5 == indexPath.row {
                guard let url = URL(string: NSLocalizedString("service_url", comment: "")) else {
                    return
                }
                let vc = LSWKViewController()
                vc.url = url
                vc.navTitle = datalist[5]
                self.navigationController?.pushViewController(vc, animated: true)
                
            }  else if 6 == indexPath.row {
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


extension LSSettingViewController: UIImagePickerControllerDelegate {
    
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           guard let chosenImage = info[.originalImage] as? UIImage  else{
               // 处理选中的图片，例如显示在UIImageView上
               picker.dismiss(animated: true, completion: nil)
               return
           }
           
           let cropController = CropViewController(croppingStyle: .circular, image: chosenImage)
           //cropController.modalPresentationStyle = .fullScreen
           cropController.delegate = self
           
           if picker.sourceType == .camera {
               picker.dismiss(animated: true, completion: {
                   self.present(cropController, animated: true, completion: nil)
               })
           } else {
               picker.pushViewController(cropController, animated: true)
           }
           
       }
       
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }
    
}

extension LSSettingViewController: CropViewControllerDelegate {
    
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        
        if let _  = cropViewController.navigationController {
            cropViewController.navigationController?.popViewController(animated: true)
        } else{
            cropViewController.dismissAnimatedFrom(self, toView: nil, toFrame: .zero) {
                
            } completion: {
                
            }

        }
    }
    
    func cropViewController(_ cropViewController: CropViewController, didCropImageToRect cropRect: CGRect, angle: Int) {
        
    }
    
    func cropViewController(_ cropViewController: CropViewController, didCropToCircularImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        
        
        cropViewController.dismissAnimatedFrom(self, toView: self.headerView?.iconView, toFrame: .zero) {
            
            
        } completion: {
            self.headerView?.iconView.image = image
        }

        
    }
}
