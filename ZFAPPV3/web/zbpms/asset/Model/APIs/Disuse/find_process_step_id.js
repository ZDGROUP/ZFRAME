export default async function call_find_process_step_id(P_process_id, P_step_order) {
    var param = [];
    param.push({ name: 'process_id', value: P_process_id });
    param.push({ name: 'step_order', value: P_step_order });
    let result = await callZf_jslib('process/', 'find_process_step_id', param, 2);
    return result;
}