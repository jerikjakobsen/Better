import { hash, argon2d} from 'argon2'

export async function argonHash(password, salt) {

    let secretBuffer = Buffer.from(process.env.HASH_SECRET)
    let memoryCost = 2 ** Number(process.env.HASH_POWER)
    let hashLength = Number(process.env.HASH_LENGTH)
    let timeCost = Number(process.env.HASH_TIME_COST)
    let saltBuffer = Buffer.from(salt)

    let options = {
        raw: true,
        type: argon2d,
        memoryCost,
        hashLength,
        timeCost,
        secret: secretBuffer,
        salt: saltBuffer
    }

    let hashedPasswordBuffer = await hash(password, options)
    let hashedPassword = hashedPasswordBuffer.toString('base64')

    return hashedPassword
}