import dotenv from 'dotenv'
dotenv.config({
    path: ["../../.env.server", "../../.env.redis", "../../.env.postgres"]
})
import app from "./src/app.js"

app.listen(process.env.NODE_SERVER_PORT, () => {
    console.log(`Listening at ${process.env.NODE_SERVER_PORT}`)
})

