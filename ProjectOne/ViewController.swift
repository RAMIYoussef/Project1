//
//  ViewController.swift
//  ProjectOne
//
//  Created by Mymac on 19/8/2022.
//

import UIKit

class ViewController: UIViewController {
    
    var pictures = [String]()
    
    @IBOutlet var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self // protocol Interface
        myTableView.dataSource = self
        // Do any additional setup after loading the view.
        title = "Storme Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self , action: #selector(recTapped))
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl"){
                // this is picture to load !
                pictures.append(item)
            }
            
        }
        pictures.sort()
        print(pictures)
        // tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.hidesBarsOnTap = false
    }
    
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return pictures.count
    //    }
    //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
    //        cell.textLabel?.text = "Picture \(indexPath.row + 1) OF \(pictures.count)"
    //        return cell
    //    }
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
    //            vc.selectedImage = pictures[indexPath.row]
    //            navigationController?.pushViewController(vc, animated: true)
    //        }
    //    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        print("did deselect \(indexPath.row)")
        
    }
}

extension ViewController: UITableViewDataSource {
    func imageWithImage(image: UIImage, scaledToSize newSize: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0 ,y: 0 ,width: newSize.width ,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.alwaysOriginal)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath) //as! ccell
        cell.textLabel?.text = "Picture \(indexPath.row + 1) OF \(pictures.count)"
        cell.imageView?.image = imageWithImage(image : UIImage(named: "\(pictures[indexPath.row])")!, scaledToSize: CGSize(width: 25, height: 20))
        
    
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
        
    }
    
    
    @objc func recTapped(){
        guard let link = URL(string: "https://apps.apple.com/us/app/idxxxxxxxx?ls=1&mt=8") else{
            print("there is a problem with sharing link")
            return
        }
        let vc = UIActivityViewController(activityItems: [link], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        
    }
}

//class ccell : UITableViewCell {
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        imageView?.frame = CGRect.init(origin: imageView!.frame.origin, size: CGSize(width: 32, height: 32))
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//}
