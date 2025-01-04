export default async function call_update_process_xml(P_bpmnxml, P_processid) {
    var param = [];
    param.push({ name: 'bpmnxml', value: P_bpmnxml });
    param.push({ name: 'processid', value: P_processid });

    let result = await callZf_jslib('process/', 'update_process_xml', param, 2);
    return result;
}
