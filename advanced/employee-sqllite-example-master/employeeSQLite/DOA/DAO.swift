//
//  DAO.swift
//  employeeSQLite
//
//  Created by Kadeem Best on 2020-05-20.
//  Copyright © 2020 ios. All rights reserved.
//

import Foundation
import SQLite3;
class DAO
{
    
    let dbPath: String = "employee.sqlite";
    var db:OpaquePointer?
    
    init()
    {
        db=openDatabase()
        createTable()
    }
    
    func openDatabase() -> OpaquePointer? {
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(self.dbPath);
        
        
        var db: OpaquePointer? = nil
        
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
            
        else
        {
            print("Successful open");
            return db;
            
        }
        
    }
    
    func createTable(){
    
        
        let createTableString = """
        CREATE TABLE IF NOT EXISTS Employee(
        id      INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName    text,
        lastName    text,
        email      text
        );
        """
        
        var createTableStatement: OpaquePointer? = nil;
        
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement,nil) == SQLITE_OK
        {
            
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("TABLE CREATED")
            }
            else
            {
                print("TABLE COULD NOT BE CREATED")
                
            }
        }
            
        else
        {
            print("create table Statment could not be prepared")
        }
        
        
        sqlite3_finalize(createTableStatement);
        
    }
    
    func addEmployee(employee:Employee)
    {
        
        
        let insertStatmentString = "INSERT INTO Employee(firstName,lastName,email) VALUES(?,?,?)";
        
        var insertStatment : OpaquePointer? = nil;
        
        if sqlite3_prepare_v2(db, insertStatmentString , -1, &insertStatment, nil) == SQLITE_OK
            
        {
            
            let firstName = employee.firstName as NSString
            let lastName = employee.lastName as NSString
            let email = employee.email as NSString
            
            sqlite3_bind_text(insertStatment, 1 ,firstName.utf8String, -1, nil)
            sqlite3_bind_text(insertStatment, 2 ,lastName.utf8String, -1, nil)
            sqlite3_bind_text(insertStatment, 3 ,email.utf8String, -1, nil)
            
            
            if sqlite3_step(insertStatment) == SQLITE_DONE
            {
                print("EMPLOYEE created successfully")
            }
            else
            {
                print("EMPLOYEEE COULD NOT BE inserted")
                
            }
        }
            
        else
        {
            print("Insert Statment could not be prepared")
        }
        
        sqlite3_finalize(insertStatment);
    }
    
    
    func getAllEmployees() -> [Employee]
    {
        let selectStatementString = "SELECT * FROM Employee";
        
        var selectStatment : OpaquePointer? = nil;
        
        var employees : [Employee] = [Employee]();
        
        if sqlite3_prepare_v2(db, selectStatementString , -1, &selectStatment, nil) == SQLITE_OK
            
        {
            while sqlite3_step(selectStatment) == SQLITE_ROW
            {
                let firstName = String(cString:sqlite3_column_text(selectStatment, 1));
                let lastName = String(cString:sqlite3_column_text(selectStatment, 2));
                let email = String(cString:sqlite3_column_text(selectStatment, 3));
                
                employees.append((Employee(firstName: firstName, lastName: lastName, email: email)));
            }
            
        }
        else
        {
            print("Select Statment could not be prepared")
        }
        sqlite3_finalize(selectStatment);
        
        return employees;
    }
    
    
    
    
}
