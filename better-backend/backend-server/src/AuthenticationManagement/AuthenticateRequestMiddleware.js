
export default function AuthenticateRequest(req, res, next) {
    const server_key = process.env.SERVER_KEY
    const cookies_server_key = req.cookies.server_key
    const authenticated = req.session.isAuthenticated
    console.log("USED Auth MIDDLEWARE")
    console.log(server_key, cookies_server_key, authenticated)
    if (!cookies_server_key || server_key !== cookies_server_key || !authenticated) {
        return res.status(400).json({"message": "Request not authenticated"})
    }

    return next()
}