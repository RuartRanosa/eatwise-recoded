import axios from 'axios'

export const register = newUser => {
    return axios
        .post('/home/register', {
            username: newUser.username,
            display_name: newUser.display_name,
            email: newUser.email,
            password: newUser.password
        })
        .then(res => {
            console.log('Registered!')
        })
}

export const login = user => {
    return axios
        .post('home/login', {
            email: user.email,
            password: user.password
        })
        .then(res => {
            localStorage.setItem('usertoken', res.data)
            return res.data
        })
        .catch(err => {
            console.log(err)
        })
}

