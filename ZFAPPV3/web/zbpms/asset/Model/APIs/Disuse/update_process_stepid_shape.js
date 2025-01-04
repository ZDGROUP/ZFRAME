export default async function call_update_process_stepid_shape(P_source_id, P_step_order, P_process_step_id) {
    var param = [];
    param.push({ name: 'source_id', value: P_source_id });
    param.push({ name: 'step_order', value: P_step_order });
    param.push({ name: 'process_step_id', value: P_process_step_id });

    let result = await callZf_jslib('process/', 'call_update_process_stepid_shape', param, 2);
    return result;
}
