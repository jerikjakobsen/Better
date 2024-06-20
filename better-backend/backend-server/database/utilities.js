import format from "pg-format"

const formatColumnValues = (values) => {
    const formatValue = (value) => {
        return "%L"
    }
    return format(values.map(formatValue).join(", "), ...values)
}

const formatColumnUpdateValues = (updatedValues) => {
    let setValues = []
    for (const [key, value] of Object.entries(updatedValues)) {
        setValues.push(format(`%I = %L`, key, value))
    }
    return setValues.join(", ")
}

const createInsertQuery = (table, insertValues) => {
    let keys, values;
    keys = []
    values = []
    for (const [key, value] of Object.entries(insertValues)) {
        keys.push(key)
        values.push(value)
    }
    const columnNames = keys.join(", ")
    const columnValues = formatColumnValues(values)

    return `
    INSERT INTO ${table} (${columnNames})
    VALUES (${columnValues})
    `
}

const createUpdateQuery = (table, updateValues, id) => {

    let keys, values;
    keys = []
    values = []
    for (const [key, value] of Object.entries(updateValues)) {
        keys.push(key)
        values.push(value)
    }
    const columnNames = keys.join(", ")
    const columnValues = formatColumnValues(values)

    return format(`
    UPDATE ${table} 
    SET ${formatColumnUpdateValues(updateValues)}
    WHERE id = %L; 
    `, id) 
}
export {
    createInsertQuery,
    createUpdateQuery
}
