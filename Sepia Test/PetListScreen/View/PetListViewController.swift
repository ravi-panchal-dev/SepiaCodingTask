//
//  PetListViewController.swift
//  Sepia Test
//
//  Created by iOS on 28/10/22.
//

import UIKit

class PetListViewController: UIViewController {

    @IBOutlet weak var tblPetList   : UITableView!
    
    lazy var viewModelPet: PetViewModel = {
            return PetViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pet List"
        self.setUpView()
    }
    
    func setUpView(){
        //register Cell
        self.tblPetList.register(UINib(nibName: petListCellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: petListCellIdentifier)

        //Get Pet Data
        viewModelPet.getPetData()
        self.tblPetList.reloadData()
    }

}

// MARK: - Tableview Methods

extension PetListViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelPet.arrPetList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: petListCellIdentifier) as? PetListTableViewCell
        let objViewModel = viewModelPet.arrPetList[indexPath.row]
        cell?.setupModelData(petData: objViewModel)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let petDetailsVC = PetDetailViewController(nibName:"PetDetailViewController",bundle:nil)
        petDetailsVC.wikiURL = viewModelPet.arrPetList[indexPath.row].wikiURL ?? ""
        petDetailsVC.petName = viewModelPet.arrPetList[indexPath.row].title ?? ""
        self.navigationController?.pushViewController(petDetailsVC, animated: true)
    }
    
}

