//
//  ListaTableViewController.swift
//  projetoIOS
//
//  Created by Luiz Guilherme on 22/09/20.
//  Copyright © 2020 Luiz Guilherme. All rights reserved.
//

import UIKit
import CoreData

class ListaTableViewController: UITableViewController {
    //@IBOutlet weak var lbDescription: UILabel!
    
    
    
    var fetchedResultController: NSFetchedResultsController<Cadastro>!
    var label = UILabel()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Nenhum cliente cadastrado"
        label.textAlignment = .center
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        
        searchController.searchBar.delegate = self
        
        loadClientes()
    }
    
    func loadClientes(filtering: String = ""){
        let fetchRequest: NSFetchRequest<Cadastro> = Cadastro.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]        
        
        if !filtering.isEmpty{
            let predicate = NSPredicate(format: "cpf contains %@", filtering)
            fetchRequest.predicate = predicate
        }
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        
        do{
        try fetchedResultController.performFetch()
        }catch{
            print(error.localizedDescription)
        }
    }
    

    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let Approve = UITableViewRowAction(style: .normal, title: "Editar") { action, index in
            self.performSegue(withIdentifier: "segueCell", sender: self)
            
        }
        Approve.backgroundColor = .blue

        
        
        let Reject = UITableViewRowAction(style: .normal, title: "Deletar") { action, index in
            guard let cliente = self.fetchedResultController.fetchedObjects?[indexPath.row] else {return}
            self.context.delete(cliente)
        }
        Reject.backgroundColor = .red

        return [Reject, Approve]
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = fetchedResultController.fetchedObjects?.count ?? 0
        tableView.backgroundView = count == 0 ? label : nil
        return count
    }

    
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ClientesTableViewCell

            guard let cadastro = fetchedResultController.fetchedObjects?[indexPath.row] else{
                return cell
            }
            cell.prepare(with: cadastro)
            //cell.name.text = cadastro.value(forKey: "title") as? String
        return cell
    }
}
extension ListaTableViewController: NSFetchedResultsControllerDelegate{
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
            
        default:
            tableView.reloadData()
        }
    }
}


extension ListaTableViewController: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadClientes()
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadClientes(filtering: searchBar.text!)
        tableView.reloadData()
    }
}
