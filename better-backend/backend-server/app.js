import express from 'express'
import cors from 'cors'
import exerciseRouter from './routes/exercise/router.js'

const app = express()

app.use(express.json())
app.use(cors())
app.options('*', cors())

app.use('/exercise', exerciseRouter)

export default app
