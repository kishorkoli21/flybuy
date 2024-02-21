//
//  SqliteDataBase.swift
//  FlyGuy
//
//  Created by Mac on 11/04/23.
//

import Foundation
import SQLite

class bt_database{
    
    //MARK: - Database Tables
    private let reportIncidentTable = Table("report_incident")
    
    //MARK: Report Incident table Columns
    private let issueName = Expression<String>("issue_name")
    private let flightNumber = Expression<String>("flight_number")
    private let reportedOnDate = Expression<String>("reported_on_date")
    private let reportedOnTime = Expression<String>("reported_on_time")
    private let lateness = Expression<String>("lateness")
    private let issueId = Expression<Int64>("id")
    
    static let instance = bt_database()
    let db: Connection?
    
    private init() {
        
        //UNComment below Path Once All db related Operations are completed and tested.
        //        let path = NSSearchPathForDirectoriesInDomains(
        //            .libraryDirectory, .userDomainMask, true
        //        ).first!
        
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        
        print("db path = :\(path)")
        do {
            db = try Connection("\(path)/bt_database.sqlite3")
            print("Database Found creating tables.")
            createReportIncidentTable()
        } catch {
            db = nil
            print ("Unable to open database")
        }
    }
    
    //MARK: - User
    func createReportIncidentTable() {
        do {
            try db!.run(reportIncidentTable.create(ifNotExists: true) { table in
                table.column(issueId, primaryKey: .autoincrement)
                table.column(flightNumber, unique: true)
                table.column(issueName)
                table.column(reportedOnDate)
                table.column(reportedOnTime)
                table.column(lateness)
                print("reportIncident table created Successfully")
            })
        } catch {
            print("Unable to create usreportIncidenter table")
        }
    }
    
    func addReportIncidentDetails(reportIncidentObject:ReportIncidentStruct){
        print("From Db Function:\(reportIncidentObject)")
        
        let insert = reportIncidentTable.insert(flightNumber <- reportIncidentObject.flightNumber, issueName <- reportIncidentObject.issueName, reportedOnDate <- reportIncidentObject.reportedOnDate, reportedOnTime <- reportIncidentObject.reportedOnTime, lateness <- reportIncidentObject.lateness)
        if let _ = try? db!.run(insert) {
            print("Report Incident Successfully inserted in Table.")
        }else{
            print("Failed to Insert Report Incident Details.")
        }
    }
    
    func getReportIncidentFromDb() -> [ReportIncidentStruct] {
        var reportIncidentStructArray = [ReportIncidentStruct]()
        do{
            for reportIncidentDetails in  try db!.prepare(reportIncidentTable.select(issueName,flightNumber,reportedOnDate,reportedOnTime,lateness)) {
               
                let temp = ReportIncidentStruct(flightNumber: reportIncidentDetails[flightNumber], issueName: reportIncidentDetails[issueName], reportedOnDate: reportIncidentDetails[reportedOnDate], reportedOnTime: reportIncidentDetails[reportedOnTime], lateness: reportIncidentDetails[lateness])
                
                reportIncidentStructArray.append(temp)
            }
        }
        catch {
            print("Error Executing Query for Subject Selection.")
        }
        return reportIncidentStructArray
       
    }
    
    
}

