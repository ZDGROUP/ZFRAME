export default async function call_get_step_count(P_source_id, P_process_id) {
    var param = [];
    param.push({ name: 'source_id', value: P_source_id });
    param.push({ name: 'process_id', value: P_process_id });
    let result = await callZf_jslib('process/', 'get_count_step', param, 2);
    return result;
}