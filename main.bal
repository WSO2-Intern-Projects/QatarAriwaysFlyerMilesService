import ballerinax/mysql;
import ballerinax/mysql.driver as _; // This bundles the driver to the project so that you don't need to bundle it via the `Ballerina.toml` file.

public type FlyerMilesEntry record {|
    int flight_distance;
|};

configurable string USER = ?;
configurable string PASSWORD = ?;
configurable string HOST = ?;
configurable string DATABASE = ?;

final mysql:Client dbClient = check new (
    host = HOST, user = USER, password = PASSWORD, database = DATABASE
);

public function findTotalMilesFlown(string customer_id) returns int|error {
    stream<FlyerMilesEntry, error?> flight_distance = dbClient->query(`SELECT qatar_airways_tb.flight_distance FROM qatar_airways_tb WHERE customer_id = ${customer_id}`);

    int total = 0;
    check flight_distance.forEach(function(FlyerMilesEntry entry) {
        total = total + entry.flight_distance;
    });

    return total;
}

