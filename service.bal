import ballerina/http;
import ballerina/log;
import ballerina/os;

//import ballerina/time;

// Configuration for the authorization server
configurable string authServerUrl = os:getEnv("AUTH_SERVER_URL");
configurable string clientId = os:getEnv("CLIENT_ID");
configurable string clientSecret =os:getEnv("CLIENT_SECRET");

// Define a Ballerina service
service /auth on new http:Listener(8081) {

    // Resource to handle HTTP GET requests
    resource function get generateToken() returns json|http:NotFound|error {
        json|error response = check getToken();
        if response is json {
            return response;
        }

    }
    // Function to obtain access token using client credentials grant type

    // Resource to handle HTTP POST requests for creating new entries
}

function getToken() returns json|error {
    // Create HTTP client
    http:Client sts = check new (authServerUrl,
        auth = {
            username: clientId,
            password: clientSecret
        }
    );

    json response = check sts->post("/oauth2/token",
            {
        "grant_type": "client_credentials"
    }
        );
    log:printInfo("Response: " + response.toString());
    return response;
}
