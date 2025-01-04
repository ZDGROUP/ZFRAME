export default class propertiesTable {
    createPropertiesTable(type, id, name, incomings, outgoings) {
        for (let properties_div of document.getElementsByClassName("properties_div")) {
            properties_div.remove();
        }

        // --------------------

        let properties_table_div = document.createElement("div");
        properties_table_div.id = "properties_div";
        properties_table_div.className = "properties_div";

        // --------------------

        let panel = document.createElement("div");
        panel.id = "panel";
        panel.className = "panel";

        properties_table_div.appendChild(panel);

        document.body.appendChild(properties_table_div);

        // --------------------

        let close_button = document.createElement("span");
        close_button.innerHTML = "X";
        close_button.title = "Close";
        close_button.className = "close_button";
        close_button.id = "close_button";
        close_button.setAttribute("onclick", "closeButton(event)");
        properties_table_div.appendChild(close_button);

        // --------------------

        var table = document.createElement('table');
        table.id = "properties_table"

        // --------------------

        var table_body = document.createElement('tbody');

        // --------------------

        var table_row_for_head = document.createElement('tr');

        var table_head = document.createElement('th');
        table_head.appendChild(document.createTextNode("Type"));
        table_row_for_head.appendChild(table_head);

        var table_head = document.createElement('th');
        table_head.appendChild(document.createTextNode("Id"));
        table_row_for_head.appendChild(table_head);

        var table_head = document.createElement('th');
        table_head.appendChild(document.createTextNode("Name"));
        table_row_for_head.appendChild(table_head);

        // --------------------

        var table_row_for_data = document.createElement('tr');

        var table_data = document.createElement('td');
        table_data.appendChild(document.createTextNode(type));
        table_row_for_data.appendChild(table_data);

        var table_data = document.createElement('td');
        table_data.appendChild(document.createTextNode(id));
        table_row_for_data.appendChild(table_data);

        var table_data = document.createElement('td');
        table_data.appendChild(document.createTextNode(name));
        table_row_for_data.appendChild(table_data);

        // --------------------

        table_body.appendChild(table_row_for_head);
        table_body.appendChild(table_row_for_data);
        table.appendChild(table_body);
        properties_table_div.appendChild(table);


        // ----------------------------------------



        var table = document.createElement('table');
        table.id = "properties_incoming_table";

        // --------------------

        var table_body = document.createElement('tbody');

        // --------------------

        var table_row_for_head = document.createElement('tr');

        var table_head = document.createElement('th');
        table_head.appendChild(document.createTextNode("InComing"));
        table_row_for_head.appendChild(table_head);
        table_body.appendChild(table_row_for_head);

        // --------------------

        if (incomings !== "None") {
            for (const incoming of incomings) {
                var table_row_for_data = document.createElement('tr');
                var table_data = document.createElement('td');
                table_data.appendChild(document.createTextNode(incoming.id));
                table_row_for_data.appendChild(table_data);
                table_body.appendChild(table_row_for_data);
            }
        } else {
            var table_row_for_data = document.createElement('tr');
            var table_data = document.createElement('td');
            table_data.appendChild(document.createTextNode(incomings));
            table_row_for_data.appendChild(table_data);
            table_body.appendChild(table_row_for_data);
        }
        table.appendChild(table_body);
        properties_table_div.appendChild(table);


        // ----------------------------------------


        var table = document.createElement('table');
        table.id = "properties_outgoing_table";

        // --------------------

        var table_body = document.createElement('tbody');

        // --------------------

        var table_row_for_head = document.createElement('tr');

        var table_head = document.createElement('th');
        table_head.appendChild(document.createTextNode("OutGoing"));
        table_row_for_head.appendChild(table_head);
        table_body.appendChild(table_row_for_head);

        // --------------------

        if (outgoings !== "None") {
            for (const outgoing of outgoings) {
                var table_row_for_data = document.createElement('tr');
                var table_data = document.createElement('td');
                table_data.appendChild(document.createTextNode(outgoing.id));
                table_row_for_data.appendChild(table_data);
                table_body.appendChild(table_row_for_data);
            }
        } else {
            var table_row_for_data = document.createElement('tr');
            var table_data = document.createElement('td');
            table_data.appendChild(document.createTextNode(outgoings));
            table_row_for_data.appendChild(table_data);
            table_body.appendChild(table_row_for_data);
        }
        table.appendChild(table_body);
        properties_table_div.appendChild(table);
    }
}