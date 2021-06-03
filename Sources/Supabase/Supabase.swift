import GoTrue
import Realtime
import SupabaseStorage

public class SupabaseClient {
    var supabaseUrl: String
    var supabaseKey: String
    var schema: String
    var restUrl: String
    var realtimeUrl: String
    var authUrl: String
    var storageUrl: String

    public var auth: GoTrueClient
    public var storage: SupabaseStorageClient {
        var headers: [String: String] = [:]
        headers["apikey"] = supabaseKey
        headers["Authorization"] = "Bearer \(auth.session?.accessToken ?? supabaseKey)"
        return SupabaseStorageClient(url: storageUrl, headers: headers)
    }

    private var realtime: RealtimeClient

    public init(supabaseUrl: String, supabaseKey: String, schema: String = "public", autoRefreshToken: Bool = true) {
        self.supabaseUrl = supabaseUrl
        self.supabaseKey = supabaseKey
        self.schema = schema
        restUrl = "\(supabaseUrl)/rest/v1"
        realtimeUrl = "\(supabaseUrl)/realtime/v1"
        authUrl = "\(supabaseUrl)/auth/v1"
        storageUrl = "\(supabaseUrl)/storage/v1"

        auth = GoTrueClient(url: authUrl, headers: ["apikey": supabaseKey], autoRefreshToken: autoRefreshToken)
        realtime = RealtimeClient(endPoint: realtimeUrl, params: ["apikey": supabaseKey])
    }
}
