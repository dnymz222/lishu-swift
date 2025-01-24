//
//  LSSupabaseTool.swift
//  lishu
//
//  Created by xueping wang on 2024/5/18.
//

import UIKit
import Supabase
import CryptoKit


private protocol ByteCountable {
  static var byteCount: Int { get }
}

extension Insecure.MD5: ByteCountable { }
extension Insecure.SHA1: ByteCountable { }

extension String {

      func insecureMD5Hash(using encoding: String.Encoding = .utf8) -> String? {
        return self.hash(algo: Insecure.MD5.self, using: encoding)
      }

      func insecureSHA1Hash(using encoding: String.Encoding = .utf8) -> String? {
        return self.hash(algo: Insecure.SHA1.self, using: encoding)
      }

  private func hash<Hash: HashFunction & ByteCountable>(algo: Hash.Type, using encoding: String.Encoding = .utf8) -> String? {
            guard let data = self.data(using: encoding) else {
              return nil
            }

            return algo.hash(data: data).prefix(algo.byteCount).map {
              String(format: "%02hhx", $0)
            }.joined()
  }

}


class LSSupabaseTool {
    
    static let share: LSSupabaseTool = .init()
    
    var client: SupabaseClient?
    var authClinet: SupabaseClient?
    var session: Session?
    
    var supabaseurl: String = "hJ0X4ioq55WzfNHD7taM5KelhSQv8nyx0xNN4g1u6bgqiVl0qr84plQ6mOxMOSJU"
    var supabasepulicAkon: String = "Ne3sN+FTWv8vxQj6Xz7HyWeKQbs5busuSy1KCj/8fBuAi+bNmKe+hJClXYk5HZDtdkFOjDGwsJOwCXFEQcM3EbgaFIL/APC7z+J3IHyj02pyAyDwI53ngpaGGma/YMvVQrGu8YwbQZh8EIiFhedROjaL9iNxvTbKdekWYJJ9NgYO2oJgir7R8VviIs0V92KDKubFTGRuRqiw4DJdY1ryDxSva+UcEQLZmHpMrF7PCCNOhrkI17g8EFInbVsNgLSVHfPuOTbQ7ZPEPVYiQXZJrg=="
    
    var supabaseServiceRoleKey: String = "Ne3sN+FTWv8vxQj6Xz7HyWeKQbs5busuSy1KCj/8fBuAi+bNmKe+hJClXYk5HZDtSaPLycZWaBasFXQT7GFxk4/9Lmqb4P8EikRucY3t6CD7aWP+vNQUBCylmN7NCbyvBuZv1Zn18wS2ZukEwQuAHIv9ps7SLiM53bQWLm9fQ+MwAVcJDBhKyTmta7q8yaCDcyMfl/4GTH9Uk8jl8bPcyzj65hnHR0Wddh5r5bA+vw867f4XYt697awg96btguoRZG6K+dsNRmzvm3OdmXHGJQ=="
    
    var supabasejwt: String = "3QrefrWmzRdf7T+LDO2kqWAJhxlydQL0mt3VeZGOVtbRZ1UGJjgrKIwmgkI3gT8K"

    
    init() {
        
        if let url = URL(string: LSToolManager.share.decryptText(self.supabaseurl)) {
            client = SupabaseClient(supabaseURL: url, supabaseKey: LSToolManager.share.decryptText(self.supabasepulicAkon))
            authClinet = SupabaseClient(supabaseURL: url, supabaseKey: LSToolManager.share.decryptText(self.supabaseServiceRoleKey))
            
        }
        
        
    }
    
    
    func  passwordMd5(_ text: String) -> String {
            
        
        let saltText = text + "clockandalmanac"
        
        guard let result =  saltText.insecureMD5Hash() else {
            return text
        }
        return result
        
    }
    
    
    func fectchConfig() async throws -> [Workingdaysconfig]{
        
        guard let client = self.client else {
            return []
        }
        
        let configs:[Workingdaysconfig] = try await client.database.from("workingdaysconfig").select().execute().value
        
        return configs
    
    }
    
    func signup() async throws{
        
        guard let client = self.client else {
            return
        }
        
        let res =    try await client.auth.signUp(email: "wangxuepingyl@163.com", password: passwordMd5("123456"),data: ["first_name":"xueping","last_name":"wang"])
        
    }
    
    
    func signin() async throws{
        
        guard let client = self.client else {
            return
        }
        
        let res =    try await client.auth.signIn(email: "wangxuepingyl@163.com", password: passwordMd5("123456"))
        
    }
    
    func logout() async {
        guard let client = self.client else {
            return
        }
        
        do {
            
          try  await client.auth.signOut()
        } catch {
            
        }
    
    }
    
    
    func deleteAccount(_ userId: String) async {
        guard let client = self.authClinet else {
            return
        }
        
        do {
            
            try  await client.auth.admin.deleteUser(id: userId)
        } catch {
#if DEBUG
                    print("error\(error)")
#endif
        }
    
    }
    
    
    
    func currentUser() async  -> User?{
        guard let client = self.client else {
            return nil
        }
        
        do {
            let user  = try await client.auth.user()
            return user
        } catch {
#if DEBUG
            print("error\(error)")
#endif
            return nil
        }
        
    }
    
    

}
