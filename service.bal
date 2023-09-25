import ballerina/http;

service /FlyerMilesService on new http:Listener(7080) {

    resource function get milesFlown/[string customer_id]() returns http:Response|xml|error? {
        string customer_id_string = customer_id;
        xml xmlValue = xml `<miles>
        <milesFlown>${check findTotalMilesFlown(customer_id)}</milesFlown>
        <customerId>${customer_id_string}</customerId>
    </miles>`;

        // io:println(xmlValue);

        // xml xmlPayload = xml `<response>
        //                         <message>Hello, World!</message>
        //                     </response>`;

        // // Create an HTTP response with the XML payload
        // http:Response response = new;
        // response.setPayload(xmlPayload);
        // response.setHeader("Content-Type", "application/xml");

        return xmlValue;
    }

}

