import {Pool} from 'pg'

const pool = Pool()

export const query = (text, params, callback) => {
    return pool.query(text, params, callback)
}
