import Foundation

struct DelayedVehicle: Codable {
    let id: String
    let isDelayed: Bool
    let delayDuration: TimeInterval
}

struct Direction: Codable {
    let id: String
    let name: String
}

enum Format: String, Codable {
    case xml
    case json
}

struct Locale: Codable {
    let languageCode: String
}

struct OffRouteVehicle: Codable {
    let id: String
    let isOffRoute: Bool
}

struct GeoPosition: Codable {
    let latitude: Double
    let longitude: Double
}

struct Pattern: Codable {
    let id: String
    let waypoints: [GeoPosition]
    let stops: [Stop]
}

struct Route: Codable {
    let id: String
    let name: String
    let patterns: [Pattern]
}

struct ServiceBulletin: Codable {
    let id: String
    let title: String
    let affectedRoutes: [Route]
    let affectedStops: [Stop]
    let message: String
}

struct Stop: Codable {
    let id: String
    let name: String
    let position: GeoPosition
}

struct Waypoint: Codable {
    let id: String
    let position: GeoPosition
}
struct Post: Codable {
    let id: Int
    let title: String
    let body: String
}

// Fetch Data from the API
func fetchPosts() async throws -> [Post] {
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let posts = try JSONDecoder().decode([Post].self, from: data)
    return posts
}

// Function to display the fetched data
func displayPosts(_ posts: [Post]) {
    for post in posts {
        print("ID: \(post.id)\nTitle: \(post.title)\nBody: \(post.body)\n---")
    }
}

// Main function to execute the program
func main() async {
    do {
        let posts = try await fetchPosts()
        displayPosts(posts)
    } catch {
        print("Error fetching posts: \(error)")
    }
}

// Run the main function
@main
struct CommandLineApp {
    static func main() {
        Task {
            await main()
        }
    }
}

