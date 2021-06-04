//
//  HomeViewController.swift
//  SampleApp
//
//  Created by Nakul  on 04/06/21.
//

import UIKit

class HomeViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
        
    func configure(model: TileData) {
        titleLabel.text = model.title
    }
}

struct TileData {
    let name: String
    let title: String
    
    static func getSampleTiles() -> [TileData] {
        return [TileData(name: "One", title: "Title1"),TileData(name: "Two", title: "Title2"), TileData(name: "Three", title: "Title3"),TileData(name: "Four", title: "Title4")]
    }
}




class HomeViewController: UIViewController {
    //MARK:- outlets
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource = TileData.getSampleTiles()
    
    //MARK:- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    //MARK:- actions
    @IBAction func createButtonAction(_ sender: Any) {
        showAddTileAlert()
    }
    
    
    private func showAddTileAlert(){
        let alertController = UIAlertController(title: "Add new tile", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter name"
            }
        let saveAction = UIAlertAction(title: "Add", style: UIAlertAction.Style.default, handler: { [weak self] (alert) -> Void in
                let name = alertController.textFields![0] as UITextField
                let title = alertController.textFields![1] as UITextField
                
            if let nameString = name.text, !nameString.isEmpty,
               let titleString = title.text, !titleString.isEmpty,
               let weakSelf = self{
                let newTile = TileData(name: nameString, title: titleString)
                weakSelf.dataSource.append(newTile)
                weakSelf.collectionView.insertItems(at: [IndexPath(row: weakSelf.dataSource.count - 1, section: 0)])
            }
            })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
                (action : UIAlertAction!) -> Void in })
        alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter title"
            }
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            
        self.present(alertController, animated: true, completion: nil)
    }
}


extension HomeViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeViewCell", for: indexPath) as? HomeViewCell {
            cell.configure(model: dataSource[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //deletion
        dataSource.remove(at: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
    }
}
