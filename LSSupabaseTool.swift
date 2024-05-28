//
//  LSSupabaseTool.swift
//  lishu
//
//  Created by xueping wang on 2024/5/18.
//

import UIKit
import Supabase


class LSSupabaseTool {
    
    static let share: LSSupabaseTool = .init()
    
    var client: SupabaseClient?
    
    static let supabaseurl: String = "http://supabase.xunquan.shop:8000"
    static let supabasepulicAkon: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.ewogICJyb2xlIjogImFub24iLAogICJpc3MiOiAic3VwYWJhc2UiLAogICJpYXQiOiAxNzE1ODc1MjAwLAogICJleHAiOiAxODczNjQxNjAwCn0.pumXX4nui7ZtJ6cHPjQ819s8zdr-m2rx16_oTlmACpI"

    
    init() {
        
        if let url = URL(string: LSSupabaseTool.supabaseurl) {
            client = SupabaseClient(supabaseURL: url, supabaseKey: LSSupabaseTool.supabasepulicAkon)
        }
    }
    
    
    func fectchConfig() async throws -> [Workingdaysconfig]{
        
        guard let client = self.client else {
            return []
        }
        
        let configs:[Workingdaysconfig] = try await client.database.from("workingdaysconfig").select().execute().value
        
        return configs
    
    }
    
 
    
    
    

}
