//
//  Model.swift
//  RadiusAssignment
//
//  Created by Ashok Rawat on 29/06/23.
//

struct FacilityData: Codable {
    let facilities: [Facility]
    let exclusions: [[FacilityExclusion]]
}

struct Facility: Codable {
    let facilityId: String
    let name: String
    let options: [FacilityOption]
    
    private enum CodingKeys: String, CodingKey {
        case facilityId = "facility_id"
        case name, options
    }
}

struct FacilityOption: Codable, Equatable {
    let name: String
    let icon: String
    let id: String
}

struct FacilityExclusion: Codable {
    let facilityId: String
    let optionsId: String
    
    private enum CodingKeys: String, CodingKey {
        case facilityId = "facility_id"
        case optionsId = "options_id"
    }
}
