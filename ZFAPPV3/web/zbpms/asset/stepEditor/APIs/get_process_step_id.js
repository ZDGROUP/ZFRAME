
export default async function call_get_process_step_id(P_source_id) {
    var param = [];
    param.push({ name: 'source_id', value: P_source_id });
    let result = await callZf_jslib('process/', 'get_step_id', param, 1);
    return result;
}
