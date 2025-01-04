/*!
 *     ____
 * /\/\||-|
 * Copyright (c) Z Development Group. All Rights Reserved.
 * For Get More Information About Us And Our Group , Please Check Both Of Link That Mentioned in Below.
 * http://zfapp.ir/
 * https://zdgroup.ir/
*/

// ------------------------------------------------------------

import ChangeBase from './Model/ChangeBase.js';
var change_base = new ChangeBase();

// -------------------------

import XMLParser from './Model/XMLParser.js';
import arrayDiffrence from "./Model/arrayDiffrence.js";


// -------------------------

import propertiesTable from './Model/propertiesTable.js';
var properties_table = new propertiesTable();

// -------------------------

import call_get_process_xml from './Model/APIs/get_process_xml.js';
import call_update_process_xml from './Model/APIs/update_process_xml.js';
import call_get_step_count from "./Model/APIs/get_step_count.js";
import call_insert_process_step from './Model/APIs/insert_process_step.js';
import call_get_process_step_id from "./Model/APIs/get_process_step_id.js";
import call_delete_process_step from "./Model/APIs/delete_process_step.js";

// --------------------------------------------------

var bpmnModeler = new BpmnJS({
    container: '#canvas'
});

// --------------------------------------------------

function openDiagram(bpmnXML) {
    try {
        bpmnModeler.importXML(bpmnXML);
    } catch (err) {
        console.error('Could Not Import BPMN Diagram', err);
    }
}

// --------------------------------------------------

let eventBus = bpmnModeler.get("eventBus");
eventBus.on("element.click", function (event) {
    if (event.element.constructor.name.toLowerCase() === "shape") {
        if (event.element.type === "bpmn:StartEvent"
            || event.element.type === "bpmn:Task"
            || event.element.type === "bpmn:ServiceTask"
            || event.element.type === "bpmn:UserTask"
            || event.element.type === "bpmn:EndEvent"
            || event.element.type === "bpmn:EventBasedGateway"
            || event.element.type === "bpmn:ParallelGateway"
            || event.element.type === "bpmn:ExclusiveGateway"
            || event.element.type === "bpmn:IntermediateCatchEvent") {

            let type = event.element.type.substr(5);
            let id = event.element.id;
            let name = "None";
            let incoming = "None";
            let outgoing = "None";


            if (typeof event.element.incoming[0] !== "undefined") {
                incoming = event.element.incoming;
            }
            if (typeof event.element.outgoing[0] !== "undefined") {
                outgoing = event.element.outgoing;
            }
            if (typeof event.element.businessObject.name !== "undefined") {
                name = event.element.businessObject.name;
            }

            properties_table.createPropertiesTable(type,
                id,
                name,
                incoming,
                outgoing);
        }
    }

    const panel = document.getElementById("properties_div");

    let m_pos;
    function resize(e) {
        const dx = m_pos - e.y;
        m_pos = e.y;
        panel.style.height = (parseInt(getComputedStyle(panel, '').height) + dx) + "px";
    }

    panel.addEventListener("mousedown", function (e) {
        m_pos = e.y;
        document.addEventListener("mousemove", resize, false);
    }, false);

    document.addEventListener("mouseup", function () {
        document.removeEventListener("mousemove", resize, false);
    }, false);

});

// --------------------------------------------------

function stepInformation() {
    let main_array = [];
    let process_id = GetUrlParameter('id');
    const canvas = bpmnModeler.get('canvas');
    const rootElement = canvas.getRootElement();
    let i = 0;
    for (let child of rootElement.children) {
        if (child.constructor.name.toLowerCase() === "shape") {
            if (child.type === "bpmn:StartEvent"
                || child.type === "bpmn:Task"
                || child.type === "bpmn:EndEvent"
                || child.type === "bpmn:ExclusiveGateway") {
                i++;
                let sub_array = { "process_id": process_id, "step_order": i, "step_id": child.id };
                main_array.push(sub_array);
            }
        }
    }
    return main_array;
}

// --------------------------------------------------

function elementNumber() {
    const canvas = bpmnModeler.get('canvas');
    const rootElement = canvas.getRootElement();
    let counter = 0;
    for (let child of rootElement.children) {
        if (child.constructor.name.toLowerCase() === "shape") {
            counter++;
        }
    }
    return counter;
}

// --------------------------------------------------

async function saveSteps(step_array, process_id) {
    for (const steps of step_array) {
        let step_counts = await call_get_step_count(steps.step_id, steps.process_id);
        let step_count = parseInt(step_counts[0].count);
        if (step_count == 0) {
            await call_insert_process_step(steps.process_id, steps.step_order, steps.step_id);
        }
    }

    // -------------------------

    let process_step_array_database = [];
    for (let process_step of await call_get_process_step_id(process_id)) {
        process_step_array_database.push(process_step.SOURCE_ID);
    }

    let process_step_array_bpmn = [];
    for (const steps of step_array) {
        process_step_array_bpmn.push(steps.step_id);
    }

    let array_diffrence = arrayDiffrence(process_step_array_database, process_step_array_bpmn);
    for (let diffrence of array_diffrence) {
        await call_delete_process_step(diffrence);
    }
}

// --------------------------------------------------

$(document).ready(async function () {
    let process_id = GetUrlParameter('id');
    let q = await call_get_process_xml(process_id);
    let data = q[0].BPMN_XML;
    if (data.length > 1) {
        openDiagram(change_base.baseDecode(data));
    } else {
        $.get(baseapplicationsrc +'/zbpms/asset/diagram.xml', openDiagram, 'text');
    }
});

// --------------------------------------------------

document.getElementById("save-button").addEventListener("click", async function () {
    let process_id = GetUrlParameter('id');

    let result = await bpmnModeler.saveXML({ format: true });
    await call_update_process_xml(change_base.baseEncode(result.xml), process_id);

    saveSteps(stepInformation(), process_id);

    let xml_parser = new XMLParser();
    let xml_elements = xml_parser.xmlElements(result, "*");

    for (const xml_element of xml_elements) {

        if (xml_element.tagName.toLowerCase() === "task") {
            let type_id = 1;
            let input_and_output = [];
            let task_id = xml_element.id;
            let task_name = xml_element.attributes.name.value;
            let in_comings = xml_element.getElementsByTagName("incoming");
            let out_goings = xml_element.getElementsByTagName("outgoing");
            for (const in_coming of in_comings) {
                let in_coming_id = in_coming.innerHTML;
                let in_coming_array = { "in_coming": in_coming_id };
                input_and_output.push(in_coming_array);
            }
            for (const out_going of out_goings) {
                let out_going_id = out_going.innerHTML;
                let out_going_array = { "out_going": out_going_id };
                input_and_output.push(out_going_array);
            }
        }

        // --------------------

        if (xml_element.tagName.toLowerCase() === "usertask") {
            let type_id = 6;
            let input_and_output = [];
            let user_task_id = xml_element.id;
            let user_task_name = xml_element.attributes.name.value;
            let in_comings = xml_element.getElementsByTagName("incoming");
            let out_goings = xml_element.getElementsByTagName("outgoing");
            for (const in_coming of in_comings) {
                let in_coming_id = in_coming.innerHTML;
                let in_coming_array = { "in_coming": in_coming_id };
                input_and_output.push(in_coming_array);
            }
            for (const out_going of out_goings) {
                let out_going_id = out_going.innerHTML;
                let out_going_array = { "out_going": out_going_id };
                input_and_output.push(out_going_array);
            }
        }

        // --------------------

        if (xml_element.tagName.toLowerCase() === "servicetask") {
            let type_id = 10;
            let input_and_output = [];
            let service_task_id = xml_element.id;
            let service_task_name = xml_element.attributes.name.value;
            let in_comings = xml_element.getElementsByTagName("incoming");
            let out_goings = xml_element.getElementsByTagName("outgoing");
            for (const in_coming of in_comings) {
                let in_coming_id = in_coming.innerHTML;
                let in_coming_array = { "in_coming": in_coming_id };
                input_and_output.push(in_coming_array);
            }
            for (const out_going of out_goings) {
                let out_going_id = out_going.innerHTML;
                let out_going_array = { "out_going": out_going_id };
                input_and_output.push(out_going_array);
            }
        }

        // --------------------

        // Start Event For Start Event , Message Start Event , Conditional Start Event
        if (xml_element.tagName.toLowerCase() === "startevent") {
            let type_id = 4;
            let start_event_id = xml_element.id;
            if (typeof xml_element.attributes.name !== "undefined") {
                let start_event_name = xml_element.attributes.name.value;
            }
            let out_going = xml_element.getElementsByTagName("outgoing")[0].innerHTML;
        }

        // --------------------

        // End Event For End Event , Message End Event , Cancel End Event
        if (xml_element.tagName.toLowerCase() === "endevent") {
            let type_id = 8;
            let end_event_id = xml_element.id;
            if (typeof xml_element.attributes.name !== "undefined") {
                let end_eventt_name = xml_element.attributes.name.value;
            }
            let input_and_output = [];
            let in_comings = xml_element.getElementsByTagName("incoming");
            for (const in_coming of in_comings) {
                let in_coming_id = in_coming.innerHTML;
                let in_coming_array = { "in_coming": in_coming_id };
                input_and_output.push(in_coming_array);
            }
        }

        // --------------------

        if (xml_element.tagName.toLowerCase() === "sequenceflow") {
            let type_id = 2;
            let source = xml_element.attributes.sourceRef.value;
            let target = xml_element.attributes.targetRef.value;
            if (typeof xml_element.attributes.name !== "undefined") {
                let sequence_flow_name = xml_element.attributes.name.value;
            }
            // await call_insert_process_step_maps(process_id, source, target);
        }

        // --------------------

        if (xml_element.tagName.toLowerCase() === "exclusivegateway") {
            let type_id = 3;
            let exclusive_gateway_id = xml_element.id;
            if (typeof xml_element.attributes.name !== "undefined") {
                let exclusive_gateway_name = xml_element.attributes.name.value;
            }
            let input_and_output = [];
            let in_coming_id = xml_element.getElementsByTagName("incoming")[0].innerHTML;
            let in_coming_array = { "in_coming": in_coming_id };
            input_and_output.push(in_coming_array);
            let out_goings = xml_element.getElementsByTagName("outgoing");
            for (const out_going of out_goings) {
                let out_going_id = out_going.innerHTML;
                let out_going_array = { "out_going": out_going_id };
                input_and_output.push(out_going_array);
            }
        }

        // --------------------

        if (xml_element.tagName.toLowerCase() === "parallelgateway") {
            let type_id = 7;
            let parallel_gateway_id = xml_element.id;
            if (typeof xml_element.attributes.name !== "undefined") {
                let parallel_gateway_name = xml_element.attributes.name.value;
            }
            let input_and_output = [];
            let in_coming_id = xml_element.getElementsByTagName("incoming")[0].innerHTML;
            let in_coming_array = { "in_coming": in_coming_id };
            input_and_output.push(in_coming_array);
            let out_goings = xml_element.getElementsByTagName("outgoing");
            for (const out_going of out_goings) {
                let out_going_id = out_going.innerHTML;
                let out_going_array = { "out_going": out_going_id };
                input_and_output.push(out_going_array);
            }
        }

        // --------------------

        if (xml_element.tagName.toLowerCase() === "eventbasedgateway") {
            let type_id = 11;
            let event_based_gateway_id = xml_element.id;
            if (typeof xml_element.attributes.name !== "undefined") {
                let event_based_gateway_name = xml_element.attributes.name.value;
            }
            let input_and_output = [];
            let in_comings = xml_element.getElementsByTagName("incoming");
            for (const in_coming of in_comings) {
                let in_coming_id = in_coming.innerHTML;
                let in_coming_array = { "in_coming": in_coming_id };
                input_and_output.push(in_coming_array);
            }
        }

        // --------------------

        if (xml_element.tagName.toLowerCase() === "intermediatethrowevent") {
            let type_id = 5;
            let in_coming_id = xml_element.getElementsByTagName("incoming")[0].innerHTML;
            let in_outgoing_id = xml_element.getElementsByTagName("outgoing")[0].innerHTML;
            let intermediate_throw_event_id = xml_element.id;
            if (typeof xml_element.attributes.name !== "undefined") {
                let intermediate_throw_event_name = xml_element.attributes.name.value;
            }
        }

        // --------------------

        if (xml_element.tagName.toLowerCase() === "intermediatecatchevent") {
            let type_id = 9;
            let in_coming_id = xml_element.getElementsByTagName("incoming")[0].innerHTML;
            let in_outgoing_id = xml_element.getElementsByTagName("outgoing")[0].innerHTML;
            let intermediate_catch_event_id = xml_element.id;
            if (typeof xml_element.attributes.name !== "undefined") {
                let intermediate_catch_event_name = xml_element.attributes.name.value;
            }
        }

        // --------------------

        if (xml_element.tagName.toLowerCase() === "textannotation") {
            var text = [];
            let text_annotation_id = xml_element.id;
            let text_annotation_content = xml_element.getElementsByTagName("text")[0].innerHTML;
            let sub_text = {
                "text_annotation_id": text_annotation_id,
                "text_annotation_content": text_annotation_content
            };
            text.push(sub_text);
        }

        // --------------------

        if (xml_element.tagName.toLowerCase() === "association") {
            let type_id = 12;
            let text_association_id = xml_element.id;
            let source = xml_element.attributes.sourceRef.value;
            let target = xml_element.attributes.targetRef.value;
            let sub_text = {
                "text_association_id": text_association_id,
                "source": source,
                "target": target
            };
            text.push(sub_text);
        }
    }
})

