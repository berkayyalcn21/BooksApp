//
//  SearchVC.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    var pickerView = UIPickerView()
    @IBOutlet weak var searchTableView: UITableView!
    private let tableViewKey = "SearchTableViewCell"
    var searchPresenterObject: ViewToPresenterSearchProtocol?
    var books: [Books] = []
    var categories = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Arama"
        SearchRouter.createModule(ref: self)
        searchPresenterObject?.fetchData()
        pickerView.delegate = self
        pickerView.dataSource = self
        categoryTextField.inputView = pickerView
        setupUI()
    }
    
    func setupUI() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        registerTableView()
    }
    
    func registerTableView() {
        searchTableView.register(.init(nibName: tableViewKey, bundle: nil), forCellReuseIdentifier: tableViewKey)
    }
}


extension SearchVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.text = categories[row]
    }
}

extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Clicked")
    }
}

extension SearchVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = books[indexPath.row]
        let cell = searchTableView.dequeueReusableCell(withIdentifier: tableViewKey) as! SearchTableViewCell
        DispatchQueue.global().async { [weak self] in
            let data = try! Data(contentsOf: URL(string: cellModel.artworkUrl100!)!)
            DispatchQueue.main.async { [weak self] in
                guard let _ = self else { return }
                cell.bookImageView.image = UIImage(data: data)
            }
        }
        cell.bookNameLabel.text = cellModel.name
        cell.authorNameLabel.text = cellModel.artistName
        cell.dateLabel.text = cellModel.releaseDate
        return cell
    }
}

extension SearchVC: PresenterToViewSearchProtocol {
    
    func updateData(with books: [Books]) {
        DispatchQueue.main.async {
            self.books = books
            self.searchTableView.reloadData()
        }
    }
    
    func updateError(with error: String) {
        DispatchQueue.main.async {
            self.books = []
            self.searchTableView.reloadData()
        }
    }
    
    
}
