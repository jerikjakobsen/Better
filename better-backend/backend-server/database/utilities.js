import format from "pg-format"

const formatColumnValues = (values) => {
    const formatValue = (value) => {
        switch (typeof value) {
            case "string":
                return `"%L"`
            default:
                return "%L"
        }
    }
    return format(values.map(formatValue).join(", "), ...values)
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

module.exports = {
   createInsertQuery 
}
