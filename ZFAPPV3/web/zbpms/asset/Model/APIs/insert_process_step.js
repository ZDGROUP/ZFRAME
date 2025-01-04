export default async function call_insert_process_step(P_process_id, P_step_order, P_source_id) {
    var param = [];
    param.push({ name: 'process_id', value: P_process_id });
    param.push({ name: 'step_order', value: P_step_order });
    param.push({ name: 'source_id', value: P_source_id });

    let result = await callZf_jslib('process/', 'insert_process_step_shap', param, 2);
    return result;
}
