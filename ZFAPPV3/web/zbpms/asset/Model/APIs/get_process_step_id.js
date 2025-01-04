export default async function call_get_process_step_id(P_process_id) {
    var param = [];
    param.push({ name: 'process_id', value: P_process_id });
    let result = await callZf_jslib('process/', 'get_process_step_id', param, 2);
    return result;
}
