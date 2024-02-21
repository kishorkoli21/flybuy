//
//  ReportIncidentModel.swift
//  FlyGuy
//
//  Created by Mac on 11/04/23.
//

import Foundation

struct ReportIncidentStruct {
    var flightNumber, issueName, reportedOnDate, reportedOnTime, lateness: String
    init(flightNumber: String, issueName: String, reportedOnDate: String, reportedOnTime: String, lateness: String) {
        self.flightNumber   = flightNumber
        self.issueName = issueName
        self.reportedOnDate  = reportedOnDate
        self.reportedOnTime  = reportedOnTime
        self.lateness  = lateness
    }
}
