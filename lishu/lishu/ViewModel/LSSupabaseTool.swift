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
    var supabasepulicAkon: String = "Ne3sN+FTWv8vxQj6Xz7HyWeKQbs5busuSy1KCj/8fBuAi+bNmKe+hJClXYk5HZDtdkFOjDGwsJOwCXFEQcM3EbgaFIL/APC7z+J3IHyj02pyAyDwI53ngpaGGma/YMvV3z1zDKE5h/898fQvsm7gR10QmlvmtcN7vY+1QLPTdzO4qY3GoH6g7SFxQDjFshJsDBc6OJkcugSNYCHkrr1GsjASYcpqJPEDBbWA/8ncXlH2kmR6udale3wewr+Nqs5kHfPuOTbQ7ZPEPVYiQXZJrg="
    
    var supabaseServiceRoleKey: String = "Ne3sN+FTWv8vxQj6Xz7HyWeKQbs5busuSy1KCj/8fBuAi+bNmKe+hJClXYk5HZDtSaPLycZWaBasFXQT7GFxk4/9Lmqb4P8EikRucY3t6CD7aWP+vNQUBCylmN7NCbyvBuZv1Zn18wS2ZukEwQuAHML/TO9QgZZezIBfwvphb+AwAVcJDBhKyTmta7q8yaCDL/08aaFws9bQUaDJD4cGhYpM8FA+WRXibF/cmvLo3tSdEl5QgeIn5gkpI+RBktS/AvDt026MuGZ8obET9HoOnQ=="
    
    var supabasejwt: String = "J+/IDbFoRh03pC4+B52afYxc9Zb2bVLxxOSAseq9a+e1ECedNuPpoLajatB/A0AG"

    
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
