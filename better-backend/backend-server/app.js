import express from 'express'
import cors from 'cors'
import routineRouter from './routes/routine/routineRouter.js'
import homeRouter from './routes/home/homeRouter.js'
import exerciseRouter from './routes/exercise/exerciseRouter.js'
const app = express()

app.use(express.json())
app.use(cors())
app.options('*', cors())

app.use('/routine', routineRouter)
app.use('/home', homeRouter)
app.use('/exercise', exerciseRouter)

export default app
