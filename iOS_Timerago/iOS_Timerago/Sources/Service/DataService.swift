//
//  LocalFileManager.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/06.
//

import Foundation


class DataService : ObservableObject {
   
    @Published var routines:[RoutineModel]? 
    
    let fileManager = FileManager.default
    
    let documentPath:URL
    
    let directoryPath:URL
    init(){
        documentPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        directoryPath = documentPath.appendingPathComponent("Routine")
        
        routines = loadJsonFile()
    }
    
    func saveJsonData(data:[RoutineModel]) {
        
        let jsonEncoder = JSONEncoder()
        
        
        do {
            let encodedData = try jsonEncoder.encode(data)
            
            let fileURL = directoryPath.appendingPathComponent("routineData.json")
            
            do {
                try encodedData.write(to: fileURL)
            }
            
            catch let err as NSError {
                print("# write Error \(err.localizedDescription)")
            }
        } catch {
            print("## encode Error \(error.localizedDescription)")
        }
        
    }
    
    func loadJsonFile() -> [RoutineModel]? {
        
        let jsonDecoder = JSONDecoder()
        
        
        do {
            let fileURL = directoryPath.appendingPathComponent("routineData.json")
            
            let jsonData = try Data(contentsOf: fileURL,options: .mappedIfSafe)
            
            let decodeRoutines = try jsonDecoder.decode([RoutineModel].self, from: jsonData)
            
            return decodeRoutines
        } catch {
            print("load Error \(error.localizedDescription)")
            return nil
        }
        
        
    }
 
}
