//
//  LeaderboardTableViewController.swift
//  Duality.gg
//
//  Created by user189106 on 9/29/21.
//

import UIKit

class LeaderboardTableViewController: UITableViewController {

    
    //var datos = ["1","2"]
    var datos = [Leaderboard]()
    var lbControlador = LeaderboardController()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        lbControlador.fetchLeaderboard{ (resultado) in
            switch resultado{
            case .success(let listaLb):self.updateGUI(listaLb: listaLb)
            case .failure(let error):self.displayError(e: error)
            }
            
        }
    }
    
    func updateGUI(listaLb: Leaderboards){
        DispatchQueue.main.async {
            self.datos = listaLb
            
            self.tableView.reloadData()
        }
        
    }
    func displayError(e:Error){
        DispatchQueue.main.async {
            let alerta =  UIAlertController(title: "Error de conexion", message: e.localizedDescription, preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
            self.present(alerta, animated: true, completion: nil)
        }
    }
    /*
    func update(with leaderboard: Leaderboard){
        rankLabel.text = String(leaderboard.players[0].rankedRating)
        gnLabel.text = leaderboard.players[0].gameName

    }*/

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return datos.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return datos[section].players.count
        }
        return datos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath)
        
                // Configure the cell...
        cell.textLabel?.textColor = UIColor.black
        //cell.backgroundColor = UIColor.clear
        //cell.textLabel?.text = datos[indexPath.row]
        //cell.textLabel?.text = datos[indexPath.row].players[0].gameName
        if indexPath.section == 0 {
            cell.textLabel?.text = String(datos[indexPath.section].players[indexPath.row].leaderboardRank)
            cell.detailTextLabel?.text = datos[indexPath.section].players[indexPath.row].gameName
            
        }
        
        
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
