export default async function call_get_process_xml(P_processid) {
    var param = [];
    param.push({ name: 'processid', value: P_processid });
    let result = await callZf_jslib('process/', 'get_process_xml', param, 2);
    return result;
}