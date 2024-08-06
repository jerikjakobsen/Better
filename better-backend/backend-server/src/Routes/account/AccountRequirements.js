const checkPassword = (password) => {
    let issues = []

    if (password.length < 12) {
        issues.push("Password must be 12 or more characters")
    }
    
    if (!(/[A-Z]/.test(password))) {
        issues.push("Password must contain an uppercase character")
    }

    if (!(/[a-z]/.test(password))) {
        issues.push("Password must contain a lowercase character")
    }

    if (!(/[0-9]/.test(password))) {
        issues.push("Password must contain an number")
    }

    if(!/[^A-Za-z0-9]/.test(password)) {
        issues.push("Password must contain a special character")
    }

    return issues
}

const checkEmail = (email) => {
    let match = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(email)
    return match
}

export {
    checkPassword,
    checkEmail
}